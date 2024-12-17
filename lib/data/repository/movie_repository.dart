import 'dart:convert';

import 'package:movie_db/data/api/endpoints.dart';
import 'package:movie_db/data/data_provider/movie_data_provider.dart';
import 'package:movie_db/models/movie_model.dart';

class MovieRepository {
  final MovieDataProvider movieDataProvider;
  MovieRepository(this.movieDataProvider);

  Future<List<MovieModel>> getMovieList({
    required Map<String, String> headers,
    Map<String, String>? queryParams,
  }) async {
    try {
      final movieData = await movieDataProvider.get(
        endpoint: API_GET_MOVIES,
        headers: headers,
        queryParams: queryParams,
      );

      final data = jsonDecode(movieData);

      if (data['results'] == null) {
        throw 'No results found';
      }

      final movies = (data['results'] as List)
          .map((json) => MovieModel.fromMap(json))
          .toList();

      return movies;
    } catch (e) {
      throw e.toString();
    }
  }
}
