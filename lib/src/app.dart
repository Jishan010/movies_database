import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/src/models/item_model.dart';
import 'package:movies_database/src/screens/home_screen.dart';
import 'package:movies_database/src/screens/movie_detail.dart';
import 'package:movies_database/src/screens/registration_screen.dart';
import 'package:movies_database/src/screens/search_movie.dart';

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  final routerDelegate = BeamerDelegate(
    initialPath: '/',
    notFoundPage: const BeamPage(
      key: ValueKey('not-found'),
      child: Scaffold(
        body: Center(
          child: Text('404 - Not Found'),
        ),
      ),
    ),
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => Scaffold(body: RegisterScreen()),
        '/home': (context, state, data) => const HomeScreen(),
        '/search': (context, state, data) => const SearchMovie(),
        '/movieDetail': (context, state, data) {
          ItemModel itemModel = data as ItemModel;
          return MovieDetail(
            title: itemModel.results[0].title,
            posterUrl: itemModel.results[0].posterPath,
            description: itemModel.results[0].overview,
            releaseDate: itemModel.results[0].releaseDate,
            voteAverage: itemModel.results[0].voteAverage,
            movieId: itemModel.results[0].id,
            backdropPath: itemModel.results[0].backdropPath,
            originalLanguage: itemModel.results[0].originalLanguage,
          );
        },
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
