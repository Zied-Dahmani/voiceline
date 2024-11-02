import 'dart:math';
import 'dart:typed_data';
import 'package:image/image.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:voiceline/domain/repositories/classifier_repository_interface.dart';
import 'package:voiceline/domain/usecases/classifier/classifier_use_case_interface.dart';
import 'package:collection/collection.dart';

class ClassifierUseCase extends IClassifierUseCase {
  final IClassifierRepository _classifierRepository;

  ClassifierUseCase(this._classifierRepository);

  /// This function preprocesses an image, performs inference using a TF Lite interpreter, and returns the category with the highest probability
  @override
  Category predict(Uint8List imageBytes) {
    final Image img = decodeImage(imageBytes)!;
    TensorImage inputImage = TensorImage(_classifierRepository.interpreter.getInputTensor(0).type)..loadImage(img);
    inputImage = _preProcess(inputImage);

    _classifierRepository.interpreter.run(inputImage.buffer, _classifierRepository.outputBuffer.getBuffer());

    final Map<String, double> labeledProb = TensorLabel.fromList(
      _classifierRepository.labels,
      _classifierRepository.probabilityProcessor.process(_classifierRepository.outputBuffer),
    ).getMapWithFloatValue();

    return _getTopProbability(labeledProb);
  }

  /// This function resizes and preprocesses the input image to match the expected dimensions and normalization requirements specified by the model for inference
  TensorImage _preProcess(TensorImage inputImage) {
    final int cropSize = min(inputImage.height, inputImage.width);
    return ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(_classifierRepository.interpreter.getInputTensor(0).shape[1], _classifierRepository.interpreter.getInputTensor(0).shape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .add(NormalizeOp(127.5, 127.5))
        .build()
        .process(inputImage);
  }

  /// Function to get the highest probability label from the predictions
  Category _getTopProbability(Map<String, double> labeledProb) {
    final PriorityQueue<MapEntry<String, double>> pq = PriorityQueue<MapEntry<String, double>>((MapEntry<String, double> e1, MapEntry<String, double> e2) => e2.value.compareTo(e1.value));
    pq.addAll(labeledProb.entries);
    final MapEntry<String, double> top = pq.first;
    return Category(top.key, top.value);
  }

  /// Close the interpreter and release resources
  @override
  void close() {
    _classifierRepository.close();
  }
}
