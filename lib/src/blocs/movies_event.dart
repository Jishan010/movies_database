import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MoviesEvent extends Equatable {}

class FetchMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];
}

class FetchMoviesByQuery extends MoviesEvent {
  final String query;

  FetchMoviesByQuery({required this.query});

  @override
  List<Object?> get props => [query];
}
