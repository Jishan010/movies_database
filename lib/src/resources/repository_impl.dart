import 'dart:async';
import 'package:movies_database/src/resources/repository.dart';

import '../models/trailer_model.dart';
import 'movie_api_provider.dart';
import '../models/item_model.dart';

class RepositoryImpl extends Repository {
  final _moviesApiProvider = MovieApiProvider();

  @override
  Future<ItemModel> fetchAllMovies() => _moviesApiProvider.fetchMovieList();

  @override
  Future<TrailerModel> fetchTrailers(int movieId) =>
      _moviesApiProvider.fetchTrailer(movieId);

  @override
  Future<ItemModel> searchMoviesFromQuery(String query) =>
      _moviesApiProvider.fetchMoviesBySearcgQuery(query);
}
