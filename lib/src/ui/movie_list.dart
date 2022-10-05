import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/src/di/locator.dart';
import 'package:movies_database/src/models/item_model.dart';
import '../blocs/movies_event.dart';
import '../blocs/movies_list_bloc.dart';
import '../blocs/movies_state.dart';
import '../database/fav_movies_dao.dart';
import '../resources/remote_repository.dart';
import 'movie_detail.dart';
import '../blocs/movie_detail_bloc_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesList extends StatelessWidget {
  final FavMoviesDao favMoviesDao;

  const MoviesList(this.favMoviesDao, {Key? key}) : super(key: key);

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
                      backgroundColor: Colors.black12,
                      actions: [
                        IconButton(
                            iconSize: 30,
                            onPressed: () {},
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
                    return buildMovieList(state.listOfmovies);
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

  Widget searchField() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Eg. The Dark Knight',
          prefixIcon: Icon(Icons.search),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
          } else {}
        },
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

  Widget buildMovieList(listOfmovies) {
    return GridView.builder(
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            padding: const EdgeInsets.all(10.0),
            child: Stack(children: [
              Card(
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${listOfmovies.results[index].posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(10.0),
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listOfmovies.results[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        listOfmovies.results[index].releaseDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        listOfmovies.results[index].overview,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
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

class MoviesLoaded {
  final List<ItemModel> listOfmovies;

  MoviesLoaded(this.listOfmovies);
}
