class MovieModel {
  final bool adult, video;
  final String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      title;
  final int id, voteCount;
  final num popularity, voteAverage;
  final List<int> genreIds;

  MovieModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      adult = json["adult"],
      backdropPath = json["backdrop_path"],
      genreIds = List<int>.from(json["genre_ids"]),
      originalLanguage = json["original_language"],
      overview = json["overview"],
      popularity = json["popularity"],
      posterPath = json["poster_path"],
      releaseDate = json["release_date"],
      title = json["title"],
      video = json["video"],
      voteAverage = json["vote_average"],
      voteCount = json["vote_count"],
      originalTitle = json["original_title"];
}

// class MovieModel {
//   final bool adult, video;
//   final String backdropPath,
//       originalLanguage,
//       originalTitle,
//       overview,
//       posterPath,
//       releaseDate,
//       title;
//   final int id, voteCount;
//   final num popularity, voteAverage;
//   final List<int> genreIds;

//   MovieModel.fromJson(Map<String, dynamic> json)
//     : id = json['id'],
//       adult = json["adult"],
//       backdropPath = json["backdrop_path"],
//       genreIds = List<int>.from(json["genre_ids"]),
//       originalLanguage = json["original_language"],
//       overview = json["overview"],
//       popularity = json["popularity"],
//       posterPath = json["poster_path"],
//       releaseDate = json["release_date"],
//       title = json["title"],
//       video = json["video"],
//       voteAverage = json["vote_average"],
//       voteCount = json["vote_count"],
//       originalTitle = json["original_title"];
// }
