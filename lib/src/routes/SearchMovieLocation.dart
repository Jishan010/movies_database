import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movies_database/src/screens/movie_detail.dart';

import '../screens/search_movie.dart';

class SearchMovieLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/search'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('search'),
        child: SearchMovie(),
      ),
      BeamPage(key: ValueKey('movieDetail'), child: MovieDetail()),
    ];
  }
}
