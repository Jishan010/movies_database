import '../database/fav_movies.dart';

abstract class LocalRepository {
  Future<List<FavMovies>> fetchAllMoviesFromDatabase();

  Future<bool> isFavMovie(int? id);

  Future<bool> addMovieToFav(FavMovies favMovies);

  Future<bool> removeMovieFromFav(int? id);
}
