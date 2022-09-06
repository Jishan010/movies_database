import 'package:floor/floor.dart';
import '../database/fav_movies.dart';

@dao
abstract class FavMoviesDao {
  @Query('SELECT * FROM FavMovies')
  Future<List<FavMovies>> findAllFavMovies();

  @Query('Select * from FavMovies order by id desc limit 1')
  Future<FavMovies?> getMaxFavMovies();

  @Query('SELECT * FROM FavMovies order by id desc')
  Stream<List<FavMovies>> fetchStreamData();

  @insert
  Future<void> insertFavMovies(FavMovies favMovies);

  @insert
  Future<List<int>> insertAllFavMovies(List<FavMovies> todo);

  @Query("delete from FavMovies where id = :id")
  Future<void> deleteFavMovies(int id);

  @delete
  Future<int> deleteAll(List<FavMovies> list);
}
