import 'package:movie_db/api/endpoints.dart';
import 'package:movie_db/api/helper_api_call.dart';
import 'package:movie_db/utils/secret.dart';

class API {
  API._privateConstructor();

  static final API _instance = API._privateConstructor();

  factory API() {
    return _instance;
  }

  callGetMovies() async {
    var headers = {'Content-Type': 'application/json', 'Authorization': apiKey};

    return await callAPI("GET", API_GET_MOVIES, null, headers);
  }
}