
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


@immutable
abstract class FavState extends Equatable {}

class AddToFavStateLoading extends FavState {
  @override
  List<Object?> get props => [];
}

class AddToFavSuccsessState extends FavState {
  final bool isAdded;

  AddToFavSuccsessState({required this.isAdded});

  @override
  // TODO: implement props
  List<Object?> get props => [isAdded];
}

class AddToFavErrorState extends FavState {
  final String message;

  AddToFavErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class RemoveFromFavSuccsessState extends FavState {
  final bool isRemoved;

  RemoveFromFavSuccsessState({required this.isRemoved});

  @override
  // TODO: implement props
  List<Object?> get props => [isRemoved];
}

class RemoveFromFavErrorState extends FavState {
  final String message;

  RemoveFromFavErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CheckIfMovieIsFavSuccsessState extends FavState {
  final bool isFav;

  CheckIfMovieIsFavSuccsessState({required this.isFav});

  @override
  // TODO: implement props
  List<Object?> get props => [isFav];
}

class CheckIfMovieIsFavErrorState extends FavState {
  final String message;

  CheckIfMovieIsFavErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
