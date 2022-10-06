import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../database/fav_movies.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {}

//for initial state
class FetchMovieTrailerById extends MovieDetailEvent {
  final int? id;

  FetchMovieTrailerById({required this.id});

  @override
  List<Object?> get props => [id];
}

//to add movie to favorite
class AddToFavEvent extends MovieDetailEvent {
  final FavMovies? favMovies;

  AddToFavEvent({required this.favMovies});

  @override
  // TODO: implement props
  List<Object?> get props => [favMovies];
}

//to remove movie from favorite
class RemoveFromFavEvent extends MovieDetailEvent {
  final int? movieId;

  RemoveFromFavEvent({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}

//to update movie in favorite
class UpdateToFavEvent extends MovieDetailEvent {
  final FavMovies? favMovies;

  UpdateToFavEvent({required this.favMovies});

  @override
  // TODO: implement props
  List<Object?> get props => [favMovies];
}

//to check if movie is favorite
class CheckIfMovieIsFavEvent extends MovieDetailEvent {
  final int? movieId;

  CheckIfMovieIsFavEvent({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}
