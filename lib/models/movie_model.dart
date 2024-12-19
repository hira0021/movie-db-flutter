import 'dart:convert';

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });

  MovieModel copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    String? releaseDate,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String,
      posterPath: map['poster_path'] as String,
      releaseDate: map['release_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, overview: $overview, posterPath: $posterPath, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(covariant MovieModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.overview == overview &&
      other.posterPath == posterPath &&
      other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      overview.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode;
  }
}
