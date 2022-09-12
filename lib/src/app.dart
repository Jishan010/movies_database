import 'package:flutter/material.dart';
import 'package:movies_database/src/database/fav_movies_dao.dart';
import 'ui/movie_list.dart';

class App extends StatelessWidget {
  final FavMoviesDao favMoviesDao;

  const App(
    this.favMoviesDao, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: MovieList(favMoviesDao),
      ),
    );
  }
}
