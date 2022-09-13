import 'package:flutter/material.dart';
import 'package:movies_database/src/database/fav_movies.dart';
import '../database/fav_movies_dao.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';
import 'movie_detail.dart';
import '../blocs/movie_detail_bloc_provider.dart';

class MovieList extends StatefulWidget {
  final FavMoviesDao favMoviesDao;

  const MovieList(this.favMoviesDao, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  //function to check if movie is fav
  Future<FavMovies> isFavMovie(int? id) async {
    final favMovies = await widget.favMoviesDao.findMovieById(id!);
    if (favMovies != null) {
      return favMovies;
    } else {
      return FavMovies(id, '', '', '', '', 0);
    }
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget searchField() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Search for movies',
        ),
        onSubmitted: (value) {
          bloc.searchMoviesFromQuery(value);
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return Column(
      children: [
        searchField(),
        Expanded(
          child: GridView.builder(
              itemCount: snapshot.data?.results.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Stack(children: [
                          GridTile(
                              child: InkResponse(
                            enableFeedback: true,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].posterPath}',
                              fit: BoxFit.fill,
                            ),
                            onTap: () => openDetailPage(snapshot.data, index),
                          )),
                          StreamBuilder<FavMovies>(
                              stream: isFavMovie(snapshot.data?.results[index].id)
                                  .asStream(),
                              builder: (context, snapshot) {
                                if (snapshot.data?.isFav == 1) {
                                  return IconButton(
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        updateFaveMovies(snapshot.data, index, 0);
                                        setState(() {});
                                      });
                                } else {
                                  return IconButton(
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        updateFaveMovies(snapshot.data, index, 1);
                                        setState(() {});
                                      });
                                }
                              })
                        ]),
                      ),
                      Text(
                        snapshot.data?.results[index].title ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  void updateFaveMovies(FavMovies? movies, int index, int isFav) async {
    String? posterPath = movies?.posterPath.toString();
    int? id = movies?.id;
    String? title = movies?.title;
    String? releaseDate = movies?.releaseDate;
    String? originalLanguage = movies?.originalLanguage;
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
  }

  openDetailPage(ItemModel? data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          child: MovieDetail(
            title: data?.results[index].title,
            posterUrl: data?.results[index].backdropPath,
            description: data?.results[index].overview,
            releaseDate: data?.results[index].releaseDate,
            voteAverage: data?.results[index].voteAverage.toString(),
            movieId: data?.results[index].id,
          ),
        );
      }),
    );
  }
}
