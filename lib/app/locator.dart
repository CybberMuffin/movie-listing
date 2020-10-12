import 'package:get_it/get_it.dart';
import 'package:movie_listing/services/api_service.dart';
import 'package:movie_listing/services/movie_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<MovieService>(() => MovieService());
}
