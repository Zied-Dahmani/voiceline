import 'dart:async';
import 'dart:developer' as developer;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:voiceline/domain/repositories/classifier_repository_interface.dart';

class ClassifierRepository implements IClassifierRepository {
  late final Interpreter _interpreter;
  late final InterpreterOptions _interpreterOptions;
  late TensorBuffer _outputBuffer;
  late dynamic _probabilityProcessor;
  late List<String> _labels;

  @override
  Interpreter get interpreter => _interpreter;
  @override
  List<String> get labels => _labels;
  @override
  TensorBuffer get outputBuffer => _outputBuffer;
  @override
  TensorProcessor get probabilityProcessor => _probabilityProcessor;

  ClassifierRepository({int? threads}) {
    _interpreterOptions = InterpreterOptions();

    /// Threads are CPU resources that the interpreter uses to process inference tasks
    if (threads != null) {
      _interpreterOptions.threads = threads;
    }

    unawaited(loadModel());
    unawaited(loadLabels());
  }

  @override
  Future<void> loadModel() async {
    try {
      /// Loading the TensorFlow Lite interpreter with a machine learning model from the app's assets, including configurable options like thread settings
      _interpreter = await Interpreter.fromAsset('model_unquant.tflite', options: _interpreterOptions);

      /// Input Shape and Type: Ensure the input data is correctly formatted and typed before feeding it to the model
      /// Output Shape and Type: Ensure the output data is correctly interpreted and processed after inference
      final List<int> outputShape = _interpreter.getOutputTensor(0).shape;
      final TfLiteType outputType = _interpreter.getOutputTensor(0).type;

      /// A buffer (a region of memory allocated to store data) to hold the model's output data
      _outputBuffer = TensorBuffer.createFixedSize(outputShape, outputType);

      /// Set up a processor to apply post-processing operations, such as normalization, to the raw output before interpretation
      _probabilityProcessor = TensorProcessorBuilder().add(NormalizeOp(0, 1)).build();
    } catch (e) {
      developer.log(e.toString(), name: 'Error loading model');
    }
  }

  @override
  Future<void> loadLabels() async {
    try {
      _labels = await FileUtil.loadLabels('assets/labels.txt');
    } catch (e) {
      developer.log(e.toString(), name: 'Error loading labels');
    }
  }

  @override
  void close() {
    _interpreter.close();
  }
}
