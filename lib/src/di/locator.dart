import 'package:get_it/get_it.dart';
import 'package:movies_database/src/blocs/movies_bloc.dart';
import 'package:movies_database/src/resources/local_repository.dart';
import 'package:movies_database/src/resources/local_repository_impl.dart';

import '../resources/movie_api_data_source.dart';
import '../resources/remote_repository.dart';
import '../resources/remote_repository_impl.dart';

final getIt = GetIt.instance;

void getItInit() {
  //add depedency for bloc
  getIt.registerFactory(() => MoviesBloc(getIt(), getIt()));

  //setup dependency for repository
  getIt.registerLazySingleton<RemoteRepository>(() => RemoteRepositoryImpl(getIt()));
  getIt.registerLazySingleton<LocalRepository>(() => LocalRepositoryImpl(getIt()));

  //setup dependency for data source
  getIt.registerLazySingleton<MovieApiDatSource>(() => MovieApiDatSource());
}
