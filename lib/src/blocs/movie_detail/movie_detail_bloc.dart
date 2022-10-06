import 'package:flutter_bloc/flutter_bloc.dart';
import '../../resources/local_repository.dart';
import '../../resources/remote_repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieTrailerDetailState> {
  final RemoteRepository repository;
  final LocalRepository localRepository;

  MovieDetailBloc({required this.repository, required this.localRepository})
      : super(MovieTrailerDetailLoadingState()) {
    on<FetchMovieTrailerById>((event, emit) async {
      try {
        final trailer = await repository.fetchMovieTrailers(event.id);
        emit(MovieTrailerDetailLoadedState(trailer: trailer));
      } catch (_) {
        emit(MovieTrailerDetailErrorState(message: _.toString()));
      }
    });

    on<AddToFavEvent>((event, emit) async {
      try {
        final favMovie = await localRepository.addMovieToFav(event.favMovies!);
        emit(AddToFavSuccsessState(isAdded: favMovie));
      } catch (_) {
        emit(AddToFavErrorState(message: _.toString()));
      }
    });

    on<RemoveFromFavEvent>((event, emit) async {
      try {
        final favMovie = await localRepository.removeMovieFromFav(event.movieId!);
        emit(RemoveFromFavSuccsessState(isRemoved: favMovie));
      } catch (_) {
        emit(AddToFavErrorState(message: _.toString()));
      }
    });
  }
}
