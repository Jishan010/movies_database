import '../resources/remote_repository.dart';
import 'movies_event.dart';
import 'movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesListBloc extends Bloc<MoviesEvent, MoviesState> {
  final RemoteRepository repository;

  MoviesListBloc({required this.repository}) : super(MoviesLoadingState()) {
    on<FetchMovies>((event, emit) async {
      try {
        final movies = await repository.fetchAllMovies();
        emit(MoviesLoadedState(listOfmovies: movies));
      } catch (_) {
        emit(MoviesErrorState(message: _.toString()));
      }
    });
  }
}
