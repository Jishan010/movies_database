import 'dart:async';
import 'package:movies_database/src/database/fav_movies.dart';
import 'package:movies_database/src/resources/remote_repository.dart';

import '../models/trailer_model.dart';
import 'movie_api_data_source.dart';
import '../models/item_model.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final MovieApiDataSource _moviesApiDataSource;
  RemoteRepositoryImpl(this._moviesApiDataSource);

  @override
  Future<ItemModel> fetchAllMovies() => _moviesApiDataSource.fetchMovieList();

  @override
  Future<TrailerModel> fetchTrailers(int movieId) =>
      _moviesApiDataSource.fetchTrailer(movieId);

  @override
  Future<ItemModel> searchMoviesFromQuery(String query) =>
      _moviesApiDataSource.fetchMoviesBySearcgQuery(query);

  @override
  Future<List<FavMovies>> fetchAllMoviesFromDatabase() =>
      _moviesApiDataSource.fetchAllMoviesFromDatabase();
}
