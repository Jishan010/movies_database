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
