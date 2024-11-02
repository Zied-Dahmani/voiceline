import 'dart:typed_data';

abstract class IImageUseCase {
  Future<Uint8List> removeBackground(String imagePath);
}