import 'dart:typed_data';
import 'package:voiceline/data/sources/remote/image_data_source.dart';
import 'package:voiceline/domain/repositories/image_repositroy_interface.dart';

class ImageRepository implements IImageRepository {
  ImageRepository(this._imageDataSource);

  final ImageDataSource _imageDataSource;

  @override
  Future<Uint8List> removeBackground(String imagePath) async => await _imageDataSource.removeBackground(imagePath);
}