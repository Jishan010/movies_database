import 'package:flutter/material.dart';

class MovieCardContainer extends StatelessWidget {
  final String? posterUrl;
  final String? title;
  final String? releaseDate;
  final String? overview;
  final int? movieId;

  const MovieCardContainer({
    Key? key,
    required this.movieId,
    required this.posterUrl,
    required this.title,
    required this.releaseDate,
    required this.overview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Stack(children: [
        Hero(
          tag: "moviePoster$movieId",
          child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: posterUrl != null ? Image.network(
              'https://image.tmdb.org/t/p/w500$posterUrl', fit: BoxFit.cover,) :  const Center(child: Text('No Image', style: TextStyle(color: Colors.white,background: null),)),
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
                  title == null ? '' : title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  releaseDate == null ? '' : releaseDate!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  overview == null ? '' : overview!,
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
    );
  }
}
