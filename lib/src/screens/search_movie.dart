import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movies/movies_event.dart';
import '../blocs/movies/movies_list_bloc.dart';
import '../blocs/movies/movies_state.dart';
import '../di/locator.dart';
import '../resources/remote_repository.dart';
import 'movie_list.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  MoviesListBloc bloc = MoviesListBloc(repository: getIt<RemoteRepository>());
  final TextEditingController _controller = TextEditingController();

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
                  controller: _controller,
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
                      return MovieListScreen(
                        listOfmovies: state.listOfmovies,
                      );
                    } else if (state is MoviesLoadingState) {
                      return Center(
                        child: _controller.value.text.isEmpty ? const SizedBox() : const  CircularProgressIndicator(),
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
}
