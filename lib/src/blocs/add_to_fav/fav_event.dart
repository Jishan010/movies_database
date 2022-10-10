import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../database/fav_movies.dart';

@immutable
abstract class FavEvent extends Equatable {}

class AddToFavEvent extends FavEvent {
  final FavMovies? favMovies;

  AddToFavEvent({required this.favMovies});

  @override
  List<Object?> get props => [favMovies];
}

//to remove movie from favorite
class RemoveFromFavEvent extends FavEvent {
  final int? movieId;

  RemoveFromFavEvent({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//to check if movie is favorite
class CheckIfMovieIsFavEvent extends FavEvent {
  final int? movieId;

  CheckIfMovieIsFavEvent({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
