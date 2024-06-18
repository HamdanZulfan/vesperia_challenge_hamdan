import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFileRepository {
  final Dio _dio;

  DownloadFileRepository(this._dio);

  Future<String> downloadFile(String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      // Unduh file
      final response = await _dio.download(url, filePath);

      if (response.statusCode == 200) {
        return filePath;
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }
}
