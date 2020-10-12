import 'package:flutter/material.dart';
import 'package:movie_listing/app/locator.dart';
import 'package:movie_listing/models/movies/movie.dart';
import 'package:movie_listing/services/movie_service.dart';
import 'package:movie_listing/utils/movie_enum.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];

  Future getAllMovies() async {
    if (popularMovies.isEmpty ||
        topRatedMovies.isEmpty ||
        upcomingMovies.isEmpty) {
      final movieService = locator<MovieService>();

      popularMovies = await movieService.loadMovies(type: MovieType.popular);
      topRatedMovies = await movieService.loadMovies(type: MovieType.topRated);
      upcomingMovies = await movieService.loadMovies(type: MovieType.upcoming);

      notifyListeners();
    }
    return true;
  }

  Future getExactMovie(int id, MovieType type) async {
    final movie =
        _getMovieList(type).firstWhere((e) => e.id == id, orElse: () => null);
    if (movie.runtime == null) {
      final runtime = await locator<MovieService>().loadMovieRuntime(id: id);
      movie.runtime = runtime;
    }

    return movie;
  }

  List<Movie> _getMovieList(MovieType type) {
    switch (type) {
      case MovieType.popular:
        return popularMovies;
      case MovieType.topRated:
        return topRatedMovies;
      case MovieType.upcoming:
        return upcomingMovies;
      default:
        return popularMovies;
    }
  }
}
