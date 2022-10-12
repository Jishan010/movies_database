import '../../resources/remote_repository.dart';
import '../movies/movies_event.dart';
import 'movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesListBloc extends Bloc<MoviesEvent, MoviesState> {
  final RemoteRepository repository;

  MoviesListBloc({required this.repository}) : super(MoviesLoadingState()) {
    on<FetchPopulorMovies>((event, emit) async {
      try {
        final movies = await repository.fetchPopularMovies();
        emit(MoviesLoadedState(listOfmovies: movies));
      } catch (_) {
        emit(MoviesErrorState(message: _.toString()));
      }
    });

    on<FetchTopRatedMovies>((event, emit) async {
      try {
        final movies = await repository.fetchTopRatedMovies();
        emit(MoviesLoadedState(listOfmovies: movies));
      } catch (_) {
        emit(MoviesErrorState(message: _.toString()));
      }
    });

    on<FetchUpcomingMovies>((event, emit) async {
      try {
        final movies = await repository.fetchUpcomingMovies();
        emit(MoviesLoadedState(listOfmovies: movies));
      } catch (_) {
        emit(MoviesErrorState(message: _.toString()));
      }
    });

    on<FetchNowPlayingMovies>((event, emit) async {
      try {
        final movies = await repository.fetchNowPlayingMovies();
        emit(MoviesLoadedState(listOfmovies: movies));
      } catch (_) {
        emit(MoviesErrorState(message: _.toString()));
      }
    });

    on<FetchMoviesByQuery>((event, emit) async {
      try {
        final movies = await repository.searchMoviesFromQuery(event.query);
        emit(MoviesLoadedState(listOfmovies: movies));
      } catch (_) {
        emit(MoviesErrorState(message: _.toString()));
      }
    });

  }
}
