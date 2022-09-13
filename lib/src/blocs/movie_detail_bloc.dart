import 'dart:async';

import 'package:movies_database/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';

class MovieDetailBloc {
  final Repository _repository;
  final _movieId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailersById => _movieId.sink.add;

  Stream<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  MovieDetailBloc(this._repository) {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
        (Future<TrailerModel>? trailer, int id, int index) async {
      print(index);
      trailer = _repository.fetchTrailers(id);
      return trailer;
    }, emptyFutureTrailerModel());
  }

  Future<TrailerModel> emptyFutureTrailerModel() async {
    return TrailerModel();
  }
}
