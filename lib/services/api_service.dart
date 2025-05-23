import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String movieId = "movie?id";
  static const String nowPlaying = "now-playing";
  static const String comingSoon = "coming-soon";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> movies = json['results'];
      for (var movieData in movies) {
        final movie = MovieModel.fromJson(movieData);
        movieInstances.add(movie);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getDetailMovie(int id) async {
    final url = Uri.parse('$baseUrl/$movieId=${id.toString()}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowPlayingMovies() async {
    final url = Uri.parse('$baseUrl/$nowPlaying');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> movies = json['results'];
      return movies.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingSoonMovies() async {
    final url = Uri.parse('$baseUrl/$comingSoon');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> movies = json['results'];
      return movies.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    throw Error();
  }
}
