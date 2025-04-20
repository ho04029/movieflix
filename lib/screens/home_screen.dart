import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            sectionTitle("popular movie"),
            const SizedBox(height: 20),
            movieFutureBuilder(popularMovies),
            const SizedBox(height: 20),
            sectionTitle("Now Playing"),
            const SizedBox(height: 20),
            movieFutureBuilder(nowPlayingMovies),
            const SizedBox(height: 20),
            sectionTitle("Coming Soon"),
            const SizedBox(height: 20),
            movieFutureBuilder(comingSoonMovies),
          ],
        ),
      ),
    );
  }
}

Widget sectionTitle(String title) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  child: Text(
    title,
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
);

ListView movieList(AsyncSnapshot<List<MovieModel>> snapshot) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemBuilder: (context, index) {
      final movie = snapshot.data![index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(id: movie.id)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 180,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey,
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 120,
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 20),
  );
}

Widget movieFutureBuilder(Future<List<MovieModel>> future) {
  return FutureBuilder(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: 300,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown,
              },
              scrollbars: false,
            ),
            child: movieList(snapshot),
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    },
  );
}
