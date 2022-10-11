import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../widgets/movie_card.dart';
import 'movie_detail.dart';

class MovieListScreen extends StatelessWidget {
  final ItemModel listOfmovies;

  const MovieListScreen({Key? key, required this.listOfmovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: listOfmovies.results.length,
      itemBuilder: (context, index) {
        //add tap event to the movie poster
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetail(
                  title: listOfmovies.results[index].title,
                  posterUrl: listOfmovies.results[index].posterPath,
                  description: listOfmovies.results[index].overview,
                  releaseDate: listOfmovies.results[index].releaseDate,
                  voteAverage:
                      listOfmovies.results[index].voteAverage,
                  movieId: listOfmovies.results[index].id,
                  backdropPath: listOfmovies.results[index].backdropPath,
                  originalLanguage:
                      listOfmovies.results[index].originalLanguage,
                ),
              ),
            );
          },
          child: MovieCardContainer(
            title: listOfmovies.results[index].title,
            posterUrl: listOfmovies.results[index].posterPath,
            releaseDate: listOfmovies.results[index].releaseDate,
            movieId: listOfmovies.results[index].id,
            overview: listOfmovies.results[index].overview,
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
