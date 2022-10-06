import 'dart:async';
import 'package:floor/floor.dart';
import 'package:movies_database/src/database/fav_movies.dart';
import 'package:movies_database/src/database/fav_movies_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1,entities: [FavMovies])
abstract class AppDatabase extends FloorDatabase
{
  FavMoviesDao get favMoviesDao;
}