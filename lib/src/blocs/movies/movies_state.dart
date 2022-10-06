import 'package:flutter/foundation.dart';
import '../../models/item_model.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class MoviesState extends Equatable {}

//for initial state
class MoviesLoadingState extends MoviesState {
  @override
  List<Object?> get props => [];
}

//when movies are fetched successfully
class MoviesLoadedState extends MoviesState {
  final ItemModel listOfmovies;

  MoviesLoadedState({required this.listOfmovies});

  @override
  List<Object?> get props => [listOfmovies];
}

//for error handling
class MoviesErrorState extends MoviesState {
  final String message;

  MoviesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
