import 'dart:convert';

import 'package:movie_db/data/api/endpoints.dart';
import 'package:movie_db/data/data_provider/movie_data_provider.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/models/paginated_response_model.dart';

class MovieRepository {
  final MovieDataProvider movieDataProvider;
  MovieRepository(this.movieDataProvider);

  Future<PaginatedResponseModel<MovieModel>> getPaginatedMovieList({
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

      return PaginatedResponseModel<MovieModel>(
        page: data['page'] as int,
        results: movies,
        totalPages: data['total_pages'] as int,
        totalResults: data['total_results'] as int,
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
