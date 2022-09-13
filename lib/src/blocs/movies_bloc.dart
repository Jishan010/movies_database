import 'package:movies_database/src/resources/repository_impl.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class MoviesBloc {
  final Repository _repository;
  final _moviesFetcher = PublishSubject<ItemModel>();

  MoviesBloc(this._repository);

  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  searchMoviesFromQuery(String query) async {
    ItemModel itemModel = await _repository.searchMoviesFromQuery(query);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc(RepositoryImpl());
