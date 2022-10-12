import '../database/fav_movies.dart';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

abstract class RemoteRepository {
  Future<ItemModel> fetchPopularMovies();

  Future<ItemModel> fetchTopRatedMovies();

  Future<ItemModel> fetchUpcomingMovies();

  Future<ItemModel> fetchNowPlayingMovies();

  Future<TrailerModel> fetchMovieTrailers(int? movieId);

  Future<ItemModel> searchMoviesFromQuery(String query);
}
