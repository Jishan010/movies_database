import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_database/src/blocs/movies_state.dart';
import '../blocs/movie_detail_bloc_provider.dart';
import '../blocs/movies_event.dart';
import '../blocs/movies_list_bloc.dart';
import '../di/locator.dart';
import '../resources/remote_repository.dart';
import 'movie_card_container.dart';
import 'movie_detail.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  MoviesListBloc bloc = MoviesListBloc(repository: getIt<RemoteRepository>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text('Search Movie'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                color: Colors.black26,
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.topCenter,
                child: TextField(
                  onSubmitted: (String query) {
                    if (query.isNotEmpty) {
                      bloc.add(FetchMoviesByQuery(query: query));
                    }
                  },
                  autofocus: true,
                  cursorHeight: 30.0,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black87,
                ),
                height: MediaQuery.of(context).size.height - 60,
                child: BlocBuilder<MoviesListBloc, MoviesState>(
                  builder: (context, state) {
                    if (state is MoviesLoadedState) {
                      return buildMovieList(state.listOfmovies);
                    } else if (state is MoviesLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
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
    );
  }

  Widget buildMovieList(listOfmovies) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listOfmovies.results.length,
      itemBuilder: (context, index) {
        //add tap event to the movie poster
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailBlocProvider(
                  repository: getIt<RemoteRepository>(),
                  child: MovieDetail(
                    title: listOfmovies?.results[index].title,
                    posterUrl: listOfmovies?.results[index].backdropPath,
                    description: listOfmovies?.results[index].overview,
                    releaseDate: listOfmovies?.results[index].releaseDate,
                    voteAverage:
                        listOfmovies?.results[index].voteAverage.toString(),
                    movieId: listOfmovies?.results[index].id,
                  ),
                ),
              ),
            );
          },
          child: MovieCardContainer(
            title: listOfmovies?.results[index].title,
            posterUrl: listOfmovies?.results[index].posterPath,
            releaseDate: listOfmovies?.results[index].releaseDate,
            movieId: listOfmovies?.results[index].id,
            overview: listOfmovies?.results[index].overview,
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
    );
  }
}
