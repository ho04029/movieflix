import 'package:movieflix/models/genre.dart';

class MovieDetailModel {
  final String posterPath, title, overview;
  final bool adult;
  final List<Genre> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
    : posterPath = json["poster_path"],
      title = json["title"],
      overview = json["overview"],
      adult = json["adult"],
      genres =
          (json["genres"] as List)
              .map((genreJson) => Genre.fromJson(genreJson))
              .toList();
}
