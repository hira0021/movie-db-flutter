import 'dart:convert';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:http/http.dart' as http;

Future callAPI(
  String method,
  String url,
  var body,
  Map<String, String> headers,
) async {
  final chuckerClient = ChuckerHttpClient(http.Client());

  try {
    var request = http.Request(method, Uri.parse(url));
    request.headers.addAll(headers);
    if (body != null && method != "GET") {
      request.body = json.encode(body);
    }

    http.StreamedResponse response = await chuckerClient.send(request);

    if (response.statusCode == 200) {
      var resp = await response.stream.bytesToString();
      Map<String, dynamic> decode = json.decode(resp);
      return decode;
    } else {
      print("Error: ${response.reasonPhrase}");
      return response.reasonPhrase;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  } finally {
    chuckerClient.close();
  }
}
