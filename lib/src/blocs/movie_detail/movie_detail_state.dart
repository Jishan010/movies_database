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
