import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/src/di/locator.dart';
import 'package:movies_database/src/ui/search_movie.dart';
import '../blocs/movies/movies_event.dart';
import '../blocs/movies/movies_list_bloc.dart';
import '../blocs/movies/movies_state.dart';
import '../database/fav_movies_dao.dart';
import '../resources/remote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_list.dart';

class HomeScreen extends StatefulWidget {
  final FavMoviesDao favMoviesDao;

  const HomeScreen(this.favMoviesDao, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesListBloc(repository: getIt<RemoteRepository>())
        ..add(FetchMovies()),
      child: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: SafeArea(
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                      foregroundColor: Colors.white,
                      titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.black26,
                      actions: [
                        IconButton(
                            iconSize: 30,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchMovie()));
                            },
                            icon: const Icon(Icons.search))
                      ],
                      title: const Text(
                        'Watch Now',
                        style: TextStyle(color: Colors.white),
                      ),
                      floating: true,
                      pinned: true,
                      bottom: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // Creates border
                            color: Colors.green),
                        isScrollable: true,
                        dragStartBehavior: DragStartBehavior.start,
                        physics: const BouncingScrollPhysics(),
                        tabs: [
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text('Popular'),
                            ),
                          ),
                          Tab(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text('Top Rated'),
                          )),
                          Tab(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text('Upcoming'),
                          )),
                          Tab(
                              child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text('Now Playing'),
                          )),
                        ],
                      )),
                ];
              },
              body: BlocBuilder<MoviesListBloc, MoviesState>(
                builder: (context, state) {
                  if (state is MoviesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MoviesLoadedState) {
                    return MovieListScreen(
                      listOfmovies: state.listOfmovies,
                    );
                  } else if (state is MoviesErrorState) {
                    return const Center(child: Text('Error loading movies'));
                  } else {
                    return const Center(child: Text('Error loading movies'));
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

/*void updateFaveMovies(ItemModel? itemModel, int index, int isFav) async {
    String? posterPath = itemModel?.results[index].posterPath.toString();
    int? id = itemModel?.results[index].id;
    String? title = itemModel?.results[index].title;
    String? releaseDate = itemModel?.results[index].releaseDate;
    String? originalLanguage = itemModel?.results[index].originalLanguage;
    FavMovies favMovies = FavMovies(
        id!, title!, posterPath!, releaseDate!, originalLanguage!, isFav);
    widget.favMoviesDao.findMovieById(id).then((value) {
      if (value != null) {
        print("Favorite deleted $id");
        widget.favMoviesDao.deleteFavMovies(favMovies.id);
      } else {
        print("Favorite added $id");
        widget.favMoviesDao.insertFavMovies(favMovies);
      }
    });
  }*/
}
