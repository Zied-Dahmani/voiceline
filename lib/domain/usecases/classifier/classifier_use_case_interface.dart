import 'dart:typed_data';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

abstract class IClassifierUseCase {
  Category predict(Uint8List imageBytes);
  void close();
}
