import 'package:flutter/material.dart';
import 'package:movies_database/src/database/fav_movies_dao.dart';
import 'package:movies_database/src/di/locator.dart';
import 'src/app.dart';

Future<void> main() async {
  getItInit();
  WidgetsFlutterBinding.ensureInitialized();
  getIt.allReady().then((value) => runApp(App(getIt<FavMoviesDao>())));
}
