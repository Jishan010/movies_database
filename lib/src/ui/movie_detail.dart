import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_database/src/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movies_database/src/di/locator.dart';
import '../blocs/movie_detail/movie_detail_event.dart';
import '../blocs/movie_detail/movie_detail_state.dart';
import '../database/fav_movies.dart';
import '../models/trailer_model.dart';
import '../resources/local_repository.dart';
import '../resources/remote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String? title;
  final String? voteAverage;
  final String? originalLanguage;
  final int? movieId;

  const MovieDetail({
    Key? key,
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.originalLanguage = 'en',
    this.movieId,
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
    );
  }
}

class MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc movieDetailBloc = MovieDetailBloc(
      repository: getIt<RemoteRepository>(),
      localRepository: getIt<LocalRepository>());

  final String? posterUrl;
  final description;
  final releaseDate;
  final String? title;
  final String? voteAverage;
  final int? movieId;
  final String? originalLanguage;

  MovieDetailState({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
    this.originalLanguage = 'en',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          movieDetailBloc..add(FetchMovieTrailerById(id: movieId)),
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                    tag: "moviePoster$movieId",
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500$posterUrl",
                      fit: BoxFit.cover,
                    ),
                  )),
                  actions: [
                    BlocBuilder<MovieDetailBloc, MovieTrailerDetailState>(
                      builder: (context, state) {
                        if (state is AddToFavSuccsessState) {
                          return IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              //add to favorite
                              movieDetailBloc.add(AddToFavEvent(
                                  favMovies: FavMovies(
                                      id: movieId!,
                                      title: title!,
                                      posterPath: posterUrl!,
                                      description: description,
                                      releaseDate: releaseDate,
                                      originalLanguage: originalLanguage!)));
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
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
                          voteAverage ?? "",
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
                      child:
                          BlocBuilder<MovieDetailBloc, MovieTrailerDetailState>(
                        builder: (context, state) {
                          if (state is MovieTrailerDetailLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is MovieTrailerDetailLoadedState) {
                            return state.trailer.results.isNotEmpty
                                ? trailerLayout(state.trailer)
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
    return Center(
      child: Container(
        child: const Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel? data) {
    if (data!.results.length > 1) {
      return trailerItem(data, 0);
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel? data, int index) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5.0),
          height: 200.0,
          child: Stack(
            children: [
              const Icon(Icons.play_circle_filled),
              YoutubePlayer(
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  controller:
                      getYouTubePlayerController(data?.results[index].key),
                  showVideoProgressIndicator: true,
                  thumbnail: Image.network(
                    "https://img.youtube.com/vi/${data?.results[index].key}/0.jpg",
                    fit: BoxFit.cover,
                  ),
                  onReady: () {
                    getYouTubePlayerController(data?.results[index].key)
                        .addListener(() {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                    });
                  })
            ],
          ),
        ),
        Text(
          data?.results[index].name ?? "",
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  YoutubePlayerController getYouTubePlayerController(String? videoIdKey) {
    return YoutubePlayerController(
      initialVideoId: videoIdKey!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }
}
