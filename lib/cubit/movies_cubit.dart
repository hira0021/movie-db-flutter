import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/data/repository/movie_repository.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/models/paginated_response_model.dart';
import 'package:movie_db/utils/commons.dart';
import 'package:movie_db/utils/general_state.dart';
import 'package:movie_db/utils/secret.dart';

class MoviesCubit extends Cubit<GeneralState<List<MovieModel>>> {
  final MovieRepository movieRepository;

  MoviesCubit(this.movieRepository) : super(LoadingState<List<MovieModel>>());

  Future<PaginatedResponseModel<MovieModel>> getPaginatedMovieList({
    required Map<String, String> queryParams,
  }) async {
    final headers = {
      'Authorization': apiKey,
      'Content-Type': 'application/json',
    };

    try {
      final movies = await movieRepository.getPaginatedMovieList(
        headers: headers,
        queryParams: queryParams,
      );

      return movies;
    } catch (error) {
      logError("Failed to fetch movies: $error");
      emit(ErrorState<List<MovieModel>>(error.toString()));
      rethrow;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    logError(error.toString());
  }
}
