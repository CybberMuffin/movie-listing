import 'package:flutter/material.dart';
import 'package:movie_listing/models/movies/movie.dart';
import 'package:movie_listing/providers/movie_provider.dart';
import 'package:movie_listing/utils/movie_enum.dart';
import 'package:provider/provider.dart';

class MovieDescriptionScreen extends StatelessWidget {
  final Movie movie;
  final MovieType type;
  const MovieDescriptionScreen({Key key, this.movie, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future = FutureBuilder(
      future: context.watch<MovieProvider>().getExactMovie(movie.id, type),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _Description(movie: snapshot.data);
        }

        return Center(child: CircularProgressIndicator());
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Movie Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: future,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final Movie movie;
  const _Description({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> textList = [
      Text(
        movie?.title ?? '-',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'Overview: ' + (movie?.overview ?? '-'),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      Text(
        'Release date: ' + (movie?.releaseDate ?? '-'),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      Text(
        'Genre: ' + (movie?.genres?.values?.join(', ') ?? '-'),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      Text(
        'Rating: ' + (movie?.rating?.toString() ?? '-'),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      Text(
        'Duration: ' + (movie?.runtime?.toString() ?? '-') + ' minutes',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ];

    return ListView.separated(
      itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: textList[index]),
      separatorBuilder: (context, index) => Container(
        height: 1,
        width: double.infinity,
        color: Colors.white,
      ),
      itemCount: 6,
    );
  }
}
