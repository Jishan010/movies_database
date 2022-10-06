import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {}

class FetchMovieTrailerById extends MovieDetailEvent {
  final int id;
  FetchMovieTrailerById({required this.id});

  @override
  List<Object?> get props => [id];
}
