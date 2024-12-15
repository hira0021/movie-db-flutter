class MovieModel {
  final int movieId;
  final String movieTitle;

  MovieModel({
    required this.movieId,
    required this.movieTitle,
  });

  @override
  String toString() => 'MoviesModel(movieId: $movieId, movieTitle: $movieTitle)';
}
