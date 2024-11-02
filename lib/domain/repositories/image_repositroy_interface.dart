import 'dart:typed_data';

abstract class IImageRepository {
  Future<Uint8List> removeBackground(String imagePath);
}