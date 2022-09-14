import 'package:flutter/material.dart';
import 'package:movies_database/src/database/app_database.dart';
import 'package:movies_database/src/di/locator.dart';
import 'src/app.dart';

Future<void> main() async {
  getItInit();
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('movies.db').build();
  final favMoviesDao = database.favMoviesDao;
  runApp(App(favMoviesDao));
}
