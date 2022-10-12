import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_database/src/models/item_model.dart';
import 'package:movies_database/src/resources/local_repository.dart';
import '../blocs/add_to_fav/fav_bloc.dart';
import '../blocs/add_to_fav/fav_event.dart';
import '../blocs/add_to_fav/fav_state.dart';
import '../blocs/movies/movies_state.dart';
import '../di/locator.dart';
import 'movie_list.dart';

class FavMovies extends StatefulWidget {
  const FavMovies({Key? key}) : super(key: key);

  @override
  State<FavMovies> createState() => _FavMoviesState();
}

class _FavMoviesState extends State<FavMovies> {
  late FavMovieBloc bloc;
  late final TextEditingController _controller;

  @override
  void initState() {
    bloc = FavMovieBloc(localRepository: getIt<LocalRepository>())
      ..add(FetchFavMoviesEvent());
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: const Text(
            'Favorite Movies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                  ),
                  height: MediaQuery.of(context).size.height - 60,
                  child: BlocBuilder<FavMovieBloc, FavState>(
                    builder: (context, state) {
                      if (state is FetchFavMoviesSuccessState) {
                        return MovieListScreen(
                          listOfmovies: ItemModel(
                            results: state.favMovies
                                .map((e) => Result.mapFromDatabase(
                                    id: e.id,
                                    title: e.title,
                                    posterPath: e.posterPath,
                                    releaseDate: e.releaseDate,
                                    overview: e.description,
                                    voteAverage: e.voteAverage,
                                    backdropPath: e.backdropPath,
                                    originalLanguage: e.originalLanguage))
                                .toList(),
                          ),
                        );
                      } else if (state is FetchFavMoviesFailureState) {
                        return Center(
                          child: _controller.value.text.isEmpty
                              ? const SizedBox()
                              : const CircularProgressIndicator(),
                        );
                      } else if (state is MoviesErrorState) {
                        return const Center(
                          child: Text('Something went wrong!'),
                        );
                      } else {
                        return const Center(
                          child: Text('Something went wrong!'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
