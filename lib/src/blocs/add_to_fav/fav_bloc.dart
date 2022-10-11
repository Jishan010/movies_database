import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_database/src/blocs/add_to_fav/fav_event.dart';
import 'package:movies_database/src/blocs/add_to_fav/fav_state.dart';
import '../../resources/local_repository.dart';

class FavMovieBloc extends Bloc<FavEvent, FavState> {
  final LocalRepository localRepository;

  FavMovieBloc({required this.localRepository})
      : super(AddToFavStateLoading()) {
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
        final favMovie =
            await localRepository.removeMovieFromFav(event.movieId!);
        emit(RemoveFromFavSuccsessState(isRemoved: favMovie));
      } catch (_) {
        emit(AddToFavErrorState(message: _.toString()));
      }
    });


    on<CheckIfMovieIsFavEvent>((event, emit) async {
      try {
        final favMovie =
            await localRepository.isFavMovie(event.movieId!);
        emit(CheckIfMovieIsFavSuccsessState(isFav: favMovie));
      } catch (_) {
        emit(CheckIfMovieIsFavErrorState(message: _.toString()));
      }
    });

  }
}
