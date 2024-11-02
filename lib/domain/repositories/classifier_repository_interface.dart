import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

abstract class IClassifierRepository {
  List<String> get labels;
  TensorBuffer get outputBuffer;
  TensorProcessor get probabilityProcessor;
  Interpreter get interpreter;
  Future<void> loadModel();
  Future<void> loadLabels();
  void close();
}
