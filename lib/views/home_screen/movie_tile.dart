import 'package:flutter/material.dart';
import 'package:movie_listing/models/movies/movie.dart';
import 'package:movie_listing/utils/movie_enum.dart';
import 'package:movie_listing/views/movie_description/movie_description_screen.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final MovieType type;
  const MovieTile({Key key, this.movie, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDescriptionScreen(
            movie: movie,
            type: type,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.white,
          width: 2,
        )),
        child: Image.network(
          'https://image.tmdb.org/t/p/w500${movie.posterImagePath}',
        ),
      ),
    );
  }
}
