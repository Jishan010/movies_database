import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../models/trailer_model.dart';

@immutable
abstract class MovieDetailState extends Equatable {}

//for initial state
class MovieDetailLoadingState extends MovieDetailState {
  @override
  List<Object?> get props => [];
}

//when movies are fetched successfully
class MovieDetailLoadedState extends MovieDetailState {
  final TrailerModel trailer;

  MovieDetailLoadedState({required this.trailer});

  @override
  List<Object?> get props => [trailer];
}

//for moview detail error handling
class MovieDetailErrorState extends MovieDetailState {
  final String message;

  MovieDetailErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
