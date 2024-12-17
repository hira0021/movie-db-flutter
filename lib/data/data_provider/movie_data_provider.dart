import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:http/http.dart' as http;

class MovieDataProvider {
  Future<String> get({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    final chuckerClient = ChuckerHttpClient(http.Client());

    try {
      final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

      final response = await chuckerClient.get(
        uri,
        headers: headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        throw 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
