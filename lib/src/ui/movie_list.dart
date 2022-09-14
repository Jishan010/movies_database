import 'package:flutter/material.dart';
import 'package:movies_database/src/database/fav_movies.dart';
import 'package:movies_database/src/di/locator.dart';
import 'package:movies_database/src/resources/remote_repository_impl.dart';
import '../database/fav_movies_dao.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';
import '../resources/remote_repository.dart';
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

//todo experiment with GetX , bloc and provider
class MovieListState extends State<MovieList> {
  late MoviesBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = getIt<MoviesBloc>();
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
        stream:  bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          print("snapshot: ${snapshot.data}");
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
          hintText: 'Eg. The Dark Knight',
          prefixIcon: Icon(Icons.search),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            bloc.searchMoviesFromQuery(value);
          } else {
            bloc.fetchAllMovies();
          }
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshotFromNetwork) {
    return Column(
      children: [
        searchField(),
        Expanded(
          child: GridView.builder(
              itemCount: snapshotFromNetwork.data?.results.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GridTile(
                                  child: InkResponse(
                                enableFeedback: true,
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w185${snapshotFromNetwork.data?.results[index].posterPath}',
                                  fit: BoxFit.cover,
                                ),
                                onTap: () => openDetailPage(
                                    snapshotFromNetwork.data, index),
                              )),
                            ),
                            StreamBuilder<FavMovies>(
                                stream: bloc.isFavoriteMovie(snapshotFromNetwork
                                        .data?.results[index].id)
                                    .asStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.data?.isFav == 1) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            updateFaveMovies(
                                                snapshotFromNetwork.data,
                                                index,
                                                0);
                                            setState(() {});
                                          }),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          icon: const Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            updateFaveMovies(
                                                snapshotFromNetwork.data,
                                                index,
                                                1);
                                            setState(() {});
                                          }),
                                    );
                                  }
                                })
                          ]),
                        ),
                        Text(
                          snapshotFromNetwork.data?.results[index].title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  void updateFaveMovies(ItemModel? itemModel, int index, int isFav) async {
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
  }

  openDetailPage(ItemModel? data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          repository: getIt<RemoteRepository>(),
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
