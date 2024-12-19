import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/data/repository/movie_repository.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/utils/commons.dart';
import 'package:movie_db/utils/general_state.dart';
import 'package:movie_db/utils/secret.dart';

class MoviesCubit extends Cubit<GeneralState<List<MovieModel>>> {
  final MovieRepository movieRepository;

  int _currentPage = 1;

  MoviesCubit(this.movieRepository) : super(LoadingState<List<MovieModel>>());

  int get currentPage => _currentPage;

  Future<void> getMovieList({Map<String, String>? queryParams}) async {
    try {
      emit(LoadingState<List<MovieModel>>());

      final headers = {
        'Authorization': apiKey,
        'Content-Type': 'application/json',
      };

      final query = queryParams ?? {'page': _currentPage.toString()};

      final movies = await movieRepository.getMovieList(
        headers: headers,
        queryParams: query,
      );

      final currentState = state;

      if (currentState is SuccessState<List<MovieModel>>) {
        final updatedMovies = List<MovieModel>.from(currentState.data)
          ..addAll(movies);
        emit(SuccessState<List<MovieModel>>(updatedMovies));
      } else {
        emit(SuccessState<List<MovieModel>>(movies));
      }

      _currentPage++;
    } catch (error) {
      logError("Failed to fetch movies: $error");
      emit(ErrorState<List<MovieModel>>(error.toString()));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    logError(error.toString());
  }
}
