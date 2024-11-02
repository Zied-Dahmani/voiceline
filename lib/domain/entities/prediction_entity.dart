import 'dart:typed_data';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class PredictionEntity {
  final Uint8List image;
  final Category category;

  PredictionEntity(this.image, this.category);
}