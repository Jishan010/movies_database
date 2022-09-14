import '../database/fav_movies.dart';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

abstract class Repository {
  Future<ItemModel> fetchAllMovies();

  Future<TrailerModel> fetchTrailers(int movieId);

  Future<ItemModel> searchMoviesFromQuery(String query);

  Future<List<FavMovies>> fetchAllMoviesFromDatabase();
}
