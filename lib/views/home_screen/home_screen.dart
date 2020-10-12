import 'package:flutter/material.dart';
import 'package:movie_listing/providers/movie_provider.dart';
import 'package:movie_listing/utils/movie_enum.dart';
import 'package:movie_listing/views/home_screen/movie_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future = FutureBuilder(
      future: context.watch<MovieProvider>().getAllMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: MovieType.values
                .map<Widget>(
                  (type) => _PostersList(type: type),
                )
                .toList(),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: future,
    );
  }
}

class _PostersList extends StatelessWidget {
  final MovieType type;
  const _PostersList({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = _getMoviesByType(context, type);
    final size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            sectionTitle[type],
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: (size.height * 0.5) - 48 - statusBarHeight,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => MovieTile(
              movie: list[index],
              type: type,
            ),
            itemCount: list.length,
          ),
        ),
      ],
    );
  }

  List _getMoviesByType(BuildContext context, MovieType type) {
    final provider = context.watch<MovieProvider>();
    switch (type) {
      case MovieType.popular:
        return provider.popularMovies;
      case MovieType.topRated:
        return provider.topRatedMovies;
      case MovieType.upcoming:
        return provider.upcomingMovies;
      default:
        return provider.popularMovies;
    }
  }
}
