import 'dart:async';
import '../models/trailer_model.dart';
import 'movie_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final _moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => _moviesApiProvider.fetchMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) =>
      _moviesApiProvider.fetchTrailer(movieId);

  Future<ItemModel> searchMoviesFromQuery(String query) =>
      _moviesApiProvider.fetchMoviesBySearcgQuery(query);
}
