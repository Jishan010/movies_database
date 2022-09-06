import 'package:flutter/material.dart';
import 'package:movies_database/src/database/fav_movies.dart';
import '../database/app_database.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';
import 'movie_detail.dart';
import '../blocs/movie_detail_bloc_provider.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
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
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data?.results.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            footer: TextButton(
              onPressed: () {
                print("Favorite added $index");

                String? posterPath = snapshot.data?.results[index].posterPath;
                int? id = snapshot.data?.results[index].id;
                String? title = snapshot.data?.results[index].title;
                String? releaseDate = snapshot.data?.results[index].releaseDate;
                String? originalLanguage =
                    snapshot.data?.results[index].originalLanguage;
                FavMovies favMovies = FavMovies(
                    id!, title!, posterPath!, releaseDate!, originalLanguage!);

                final database =
                    $FloorAppDatabase.databaseBuilder('movies.db').build();
                database.then((onValue) {
                  // find the dao here
                  onValue.favMoviesDao.insertFavMovies(favMovies);
                  print("Favorite added $title");
                });
              },
              child: Text("Add to fevorite"),
            ),
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data, index),
            ),
          );
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
