import 'package:flutter/material.dart';
import '../resources/remote_repository.dart';
import 'movie_detail_bloc.dart';
export 'movie_detail_bloc.dart';

class MovieDetailBlocProvider extends InheritedWidget {
  final MovieDetailBloc bloc;
 final RemoteRepository repository;
  MovieDetailBlocProvider({Key? key, required Widget child,required this.repository})
      : bloc = MovieDetailBloc(repository),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static MovieDetailBloc of(BuildContext context) {
    return (context
                .dependOnInheritedWidgetOfExactType<MovieDetailBlocProvider>()
            as MovieDetailBlocProvider)
        .bloc;
  }
}
