import 'dart:typed_data';
import 'package:voiceline/domain/repositories/image_repositroy_interface.dart';
import 'package:voiceline/domain/usecases/image/image_use_case_interface.dart';

class ImageUseCase extends IImageUseCase {
  final IImageRepository _imageRepository;

  ImageUseCase(this._imageRepository);
  
  @override
  Future<Uint8List> removeBackground(String imagePath) async => await _imageRepository.removeBackground(imagePath);
}