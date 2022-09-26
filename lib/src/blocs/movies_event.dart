import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MoviesEvent extends Equatable {}

class FetchMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];
}
