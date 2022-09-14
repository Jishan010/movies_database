import '../database/fav_movies.dart';

abstract class LocalRepository {
  Future<List<FavMovies>> fetchAllMoviesFromDatabase();
  Future<FavMovies> isFavMovie(int? id);
}
