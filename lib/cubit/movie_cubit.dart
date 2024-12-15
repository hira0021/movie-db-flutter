import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/utils/commons.dart';

class MovieCubit extends Cubit<List<MovieModel>> {
  MovieCubit() : super([]);

  void getMovieList() {

  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    logError(error.toString());
  }
}
