import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:movie_listing/app/locator.dart';
import 'package:movie_listing/models/movies/movie.dart';
import 'package:movie_listing/services/api_service.dart';
import 'package:movie_listing/utils/movie_enum.dart';

class MovieService {
  Map<int, String> _genres = {};

  Future<List<Movie>> loadMovies({@required MovieType type}) async {
    final response = await _loadMovieByType(type);

    switch (response.statusCode) {
      case 200:
        final result = convert.jsonDecode(response.body);

        final List<Movie> movieList = result['results']
            .map<Movie>((element) => Movie.fromJson(element))
            .toList();

        if (_genres?.isEmpty ?? true) await _loadGenres();
        movieList.forEach((element) => element.genres
            .forEach((key, value) => element.genres[key] = _genres[key]));

        return movieList;
        break;
      default:
        return null;
        break;
    }
  }

  Future<int> loadMovieRuntime({@required int id}) async {
    final response = await locator<ApiService>().getMovieDetails(id);

    switch (response.statusCode) {
      case 200:
        final result = convert.jsonDecode(response.body);

        // final Movie movie = Movie.fromJson(result);

        // if (_genres?.isEmpty ?? true) await _loadGenres();
        // movie.genres.forEach((key, value) => movie.genres[key] = _genres[key]);

        return result['runtime'];
        break;
      default:
        return null;
        break;
    }
  }

  Future<Map<int, String>> _loadGenres() async {
    final response = await locator<ApiService>().getGenres();

    switch (response.statusCode) {
      case 200:
        final result = convert.jsonDecode(response.body);

        _genres = Map.fromIterable(result['genres'],
            key: (item) => item['id'], value: (item) => item['name']);

        return _genres;
        break;
      default:
        return {};
        break;
    }
  }

  Future _loadMovieByType(MovieType type) {
    final api = locator<ApiService>();
    switch (type) {
      case MovieType.popular:
        return api.getPopularMovies();
      case MovieType.topRated:
        return api.getTopRatedMovies();
      case MovieType.upcoming:
        return api.getUpcomingMovies();
      default:
        return null;
    }
  }
}
