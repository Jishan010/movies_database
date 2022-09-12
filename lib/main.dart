import 'package:flutter/material.dart';
import 'package:movies_database/src/database/app_database.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('movies.db').build();
  final favMoviesDao = database.favMoviesDao;
  runApp(App(favMoviesDao));
}
