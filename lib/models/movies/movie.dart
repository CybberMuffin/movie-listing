class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterImagePath;
  final String releaseDate;
  final Map<int, String> genres;
  final double rating;
  int runtime;

  Movie({
    this.id,
    this.title,
    this.overview,
    this.posterImagePath,
    this.releaseDate,
    this.genres,
    this.rating,
    this.runtime,
  });

  factory Movie.fromJson(json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterImagePath: json['poster_path'],
      releaseDate: json['release_date'],
      genres: Map.fromIterable(json['genre_ids'],
          key: (e) => e, value: (e) => null),
      rating: json['rating'],
      runtime: json['runtime'],
    );
  }
}
