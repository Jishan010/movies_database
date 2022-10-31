import 'package:beamer/beamer.dart';
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
            Beamer.of(context).beamToNamed(
              '/movieDetail',
              data: ItemModel(
                results: [
                  listOfmovies.results[index],
                ],
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
