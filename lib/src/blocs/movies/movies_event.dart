import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MoviesEvent extends Equatable {}

class FetchPopulorMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];
}

class FetchTopRatedMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];
}

class FetchUpcomingMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];
}

class FetchMoviesByQuery extends MoviesEvent {
  final String query;

  FetchMoviesByQuery({required this.query});

  @override
  List<Object?> get props => [query];
}
