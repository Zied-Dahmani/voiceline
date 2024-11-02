import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:voiceline/core/api_constants.dart';

class ImageDataSource {
  final String? _apiKey = dotenv.env[APIConstants.kRemoveBackgroundKey];

  Future<Uint8List> removeBackground(String imagePath) async {
    final http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(APIConstants.kRemoveBackgroundURL),
    );
    request.files.add(await http.MultipartFile.fromPath('image_file', imagePath));
    request.headers['X-API-Key'] = _apiKey!;

    final http.StreamedResponse streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      final http.Response response = await http.Response.fromStream(streamedResponse);
      return response.bodyBytes;
    } else {
      throw Exception('Failed to remove image background: ${streamedResponse.statusCode}');
    }
  }
}
