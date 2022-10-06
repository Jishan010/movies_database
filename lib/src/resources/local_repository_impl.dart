import 'package:movies_database/src/database/fav_movies.dart';
import 'package:movies_database/src/resources/local_repository.dart';

import 'movie_api_data_source.dart';

class LocalRepositoryImpl extends LocalRepository {
  final MovieApiDataSource _moviesApiDataSource;
  LocalRepositoryImpl(this._moviesApiDataSource);

  @override
  Future<List<FavMovies>> fetchAllMoviesFromDatabase() {
    return _moviesApiDataSource.fetchAllMoviesFromDatabase();
  }

  @override
  Future<FavMovies> isFavMovie(int? id) {
    return _moviesApiDataSource.isFavMovie(id);
  }

  @override
  Future<bool> addMovieToFav(FavMovies favMovies) {
    return _moviesApiDataSource.addMovieToFav(favMovies);
  }

  @override
  Future<bool> removeMovieFromFav(int? id) {
    return _moviesApiDataSource.deleteMovieFromFav(id);
  }
}
