import 'package:floor/floor.dart';
import '../database/fav_movies.dart';

@dao
abstract class FavMoviesDao {
  //find single moview by id
  @Query('SELECT * FROM FavMovies WHERE id = :id')
  Future<FavMovies?> findMovieById(int id);

  //is fav movie
  @Query('SELECT * FROM FavMovies')
  Future<List<FavMovies>> findAllFavMoviesList();

  @insert
  Future<void> insertFavMovies(FavMovies favMovies);

  //update fav movie
  @update
  Future<void> updateFavMovies(FavMovies favMovies);

  @insert
  Future<List<int>> insertAllFavMovies(List<FavMovies> todo);

  @Query("delete from FavMovies where id = :id")
  Future<void> deleteFavMovies(int id);

  @delete
  Future<int> deleteAll(List<FavMovies> list);
}
