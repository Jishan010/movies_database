import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_database/src/blocs/add_to_fav/fav_state.dart';
import 'package:movies_database/src/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movies_database/src/di/locator.dart';
import '../blocs/add_to_fav/fav_bloc.dart';
import '../blocs/add_to_fav/fav_event.dart';
import '../blocs/movie_detail/movie_detail_event.dart';
import '../blocs/movie_detail/movie_detail_state.dart';
import '../resources/local_repository.dart';
import '../resources/remote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/add_to_bookmark.dart';
import '../widgets/trailer_layout.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String? title;
  final double? voteAverage;
  final String? originalLanguage;
  final int? movieId;
  final String? backdropPath;

  const MovieDetail({
    Key? key,
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.originalLanguage = 'en',
    this.movieId,
    this.backdropPath,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState(
      title: title,
      posterUrl: posterUrl,
      description: description,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      movieId: movieId,
      originalLanguage: originalLanguage,
      backdropPath: backdropPath,
    );
  }
}

class MovieDetailState extends State<MovieDetail> {
  final String? posterUrl;
  final description;
  final releaseDate;
  final String? title;
  final double? voteAverage;
  final int? movieId;
  final String? originalLanguage;
  final String? backdropPath;

  MovieDetailState({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
    this.originalLanguage = 'en',
    this.backdropPath,
  });

  late MovieDetailBloc movieDetailBloc;
  late FavMovieBloc favMovieBloc;

  @override
  void initState() {
    movieDetailBloc = MovieDetailBloc(repository: getIt<RemoteRepository>())
      ..add(FetchMovieTrailerById(id: movieId));
    favMovieBloc = FavMovieBloc(
      localRepository: getIt<LocalRepository>(),
    )..add(CheckIfMovieIsFavEvent(movieId: movieId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => movieDetailBloc,
        ),
        BlocProvider<FavMovieBloc>(
          create: (context) => favMovieBloc,
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                    tag: "moviePoster$movieId",
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500$backdropPath",
                      fit: BoxFit.cover,
                    ),
                  )),
                  actions: [
                    BlocConsumer<FavMovieBloc, FavState>(
                        listener: (context, state) {
                      if (state is AddToFavSuccsessState) {
                        BlocProvider.of<FavMovieBloc>(context)
                            .add(CheckIfMovieIsFavEvent(movieId: movieId));
                      } else {
                        BlocProvider.of<FavMovieBloc>(context)
                            .add(CheckIfMovieIsFavEvent(movieId: movieId));
                      }
                    }, builder: (context, state) {
                      if (state is CheckIfMovieIsFavSuccsessState) {
                        if (state.isFav) {
                          return IconButton(
                            icon: const Icon(Icons.bookmark),
                            onPressed: () {
                              BlocProvider.of<FavMovieBloc>(context)
                                  .add(RemoveFromFavEvent(movieId: movieId));
                            },
                          );
                        } else {
                          return AddToBookmark(
                              movieId: movieId,
                              title: title,
                              posterUrl: posterUrl,
                              description: description,
                              releaseDate: releaseDate,
                              originalLanguage: originalLanguage,
                              voteAverage: voteAverage,
                              backdropPath: backdropPath);
                        }
                      } else if (state is CheckIfMovieIsFavErrorState) {
                        return AddToBookmark(
                            movieId: movieId,
                            title: title,
                            posterUrl: posterUrl,
                            description: description,
                            releaseDate: releaseDate,
                            originalLanguage: originalLanguage,
                            voteAverage: voteAverage,
                            backdropPath: backdropPath);
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(margin: const EdgeInsets.only(top: 5.0)),
                    Text(
                      title ?? "",
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                        ),
                        Text(
                          voteAverage != null ? voteAverage.toString() : "0.0",
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Text(
                          releaseDate,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Text(description),
                    Container(
                        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    const Text(
                      "Trailer",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: BlocConsumer<MovieDetailBloc,
                          MovieTrailerDetailState>(
                        listener: (context, state) {
                          if (state is MovieTrailerDetailErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is MovieTrailerDetailLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is MovieTrailerDetailLoadedState) {
                            return state.trailer.results.isNotEmpty
                                ? TrailerLayout(
                                    data: state.trailer,
                                  )
                                : noTrailer();
                          } else if (state is MovieTrailerDetailErrorState) {
                            return const Center(
                              child: Text("Error"),
                            );
                          } else {
                            return const Center(
                              child: Text("Error"),
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
        ),
      ),
    );
  }

  Widget noTrailer() {
    return const Center(
      child: Text("No trailer available"),
    );
  }
}
