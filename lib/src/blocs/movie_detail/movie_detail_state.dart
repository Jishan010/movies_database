import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../models/trailer_model.dart';

@immutable
abstract class MovieTrailerDetailState extends Equatable {}

//for initial state
class MovieTrailerDetailLoadingState extends MovieTrailerDetailState {
  @override
  List<Object?> get props => [];
}

//when movies are fetched successfully
class MovieTrailerDetailLoadedState extends MovieTrailerDetailState {
  final TrailerModel trailer;

  MovieTrailerDetailLoadedState({required this.trailer});

  @override
  List<Object?> get props => [trailer];
}

//for moview detail error handling
class MovieTrailerDetailErrorState extends MovieTrailerDetailState {
  final String message;

  MovieTrailerDetailErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddToFavSuccsessState extends MovieTrailerDetailState {
  final bool isAdded;

  AddToFavSuccsessState({required this.isAdded});

  @override
  // TODO: implement props
  List<Object?> get props => [isAdded];
}

class AddToFavErrorState extends MovieTrailerDetailState {
  final String message;

  AddToFavErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class RemoveFromFavSuccsessState extends MovieTrailerDetailState {
  final bool isRemoved;

  RemoveFromFavSuccsessState({required this.isRemoved});

  @override
  // TODO: implement props
  List<Object?> get props => [isRemoved];
}

class RemoveFromFavErrorState extends MovieTrailerDetailState {
  final String message;

  RemoveFromFavErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CheckIfMovieIsFavSuccsessState extends MovieTrailerDetailState {
  final bool isFav;

  CheckIfMovieIsFavSuccsessState({required this.isFav});

  @override
  // TODO: implement props
  List<Object?> get props => [isFav];
}

class CheckIfMovieIsFavErrorState extends MovieTrailerDetailState {
  final String message;

  CheckIfMovieIsFavErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
