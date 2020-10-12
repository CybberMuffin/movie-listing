import 'package:http/http.dart' as http;

class ApiService {
  final String _apiUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = '8101283595d74ae1f3437efc7b5b7be2';

  Future getPopularMovies() async {
    final result = await http.get(
      '$_apiUrl/movie/popular?api_key=$_apiKey',
      headers: {
        'accept': 'application/json',
      },
    );

    return result;
  }

  Future getTopRatedMovies() async {
    final result = await http.get(
      '$_apiUrl/movie/top_rated?api_key=$_apiKey',
      headers: {
        'accept': 'application/json',
      },
    );

    return result;
  }

  Future getUpcomingMovies() async {
    final result = await http.get(
      '$_apiUrl/movie/upcoming?api_key=$_apiKey',
      headers: {
        'accept': 'application/json',
      },
    );

    return result;
  }

  Future getMovieDetails(int id) async {
    final result = await http.get(
      '$_apiUrl/movie/$id?api_key=$_apiKey',
      headers: {
        'accept': 'application/json',
      },
    );

    return result;
  }

  Future getGenres() async {
    final result = await http.get(
      '$_apiUrl/genre/movie/list?api_key=$_apiKey',
      headers: {
        'accept': 'application/json',
      },
    );

    return result;
  }
}
