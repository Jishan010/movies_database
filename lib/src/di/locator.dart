import 'package:get_it/get_it.dart';
import 'package:movies_database/src/database/app_database.dart';
import 'package:movies_database/src/database/fav_movies_dao.dart';
import 'package:movies_database/src/resources/local_repository.dart';
import 'package:movies_database/src/resources/local_repository_impl.dart';
import '../data/movies_api_service.dart';
import '../resources/movie_api_data_source.dart';
import '../resources/remote_repository.dart';
import '../resources/remote_repository_impl.dart';

final getIt = GetIt.instance;

void getItInit() {
  //setup dependency for repository
  getIt.registerLazySingleton<RemoteRepository>(
      () => RemoteRepositoryImpl(getIt()));
  getIt.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImpl(getIt()));

  //setup dependency for data source
  getIt.registerLazySingleton<MovieApiDataSource>(
      () => MovieApiDataSource(getIt(),getIt()));

  //setup depedency for api client
  getIt.registerLazySingleton<MovieApiService>(() => MovieApiService.create());

  //setup dependency for database
  //way to register async dependency
  getIt.registerSingletonAsync<AppDatabase>(
      () async => await $FloorAppDatabase.databaseBuilder('movies.db').build());

  getIt.registerLazySingleton<FavMoviesDao>(() => getIt<AppDatabase>().favMoviesDao);
}
