import 'package:flutter_bloc/flutter_bloc.dart';
import '../resources/remote_repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final RemoteRepository repository;

  MovieDetailBloc({required this.repository})
      : super(MovieDetailLoadingState()) {
    on<FetchMovieTrailerById>((event, emit) async {
      try {
        final trailer = await repository.fetchMovieTrailers(event.id);
        emit(MovieDetailLoadedState(trailer: trailer));
      } catch (_) {
        emit(MovieDetailErrorState(message: _.toString()));
      }
    });
  }
}
