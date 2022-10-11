
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../database/fav_movies.dart';
import '../blocs/add_to_fav/fav_bloc.dart';
import '../blocs/add_to_fav/fav_event.dart';

class AddToBookmark extends StatelessWidget {
  const AddToBookmark({
    Key? key,
    required this.movieId,
    required this.title,
    required this.posterUrl,
    required this.description,
    required this.releaseDate,
    required this.originalLanguage,
  }) : super(key: key);

  final int? movieId;
  final String? title;
  final String? posterUrl;
  final String? description;
  final String? releaseDate;
  final String? originalLanguage;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.bookmark_add_outlined),
      onPressed: () {
        BlocProvider.of<FavMovieBloc>(context).add(AddToFavEvent(
            favMovies: FavMovies(
              id: movieId!,
              title: title!,
              posterPath: posterUrl!,
              description: description!,
              releaseDate: releaseDate!,
              originalLanguage: originalLanguage!,
            )));
      },
    );
  }
}