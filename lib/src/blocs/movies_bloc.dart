import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_database/src/database/fav_movies.dart';
import 'package:movies_database/src/resources/local_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/remote_repository.dart';

class MoviesBloc {
  final RemoteRepository _repository;
  final LocalRepository _localRepository;
  final _moviesFetcher = PublishSubject<ItemModel>();

  MoviesBloc(this._repository, this._localRepository);

  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    await InternetConnectionChecker().hasConnection.then((value) async {
      if (value) {
        ItemModel itemModel = await _repository.fetchAllMovies();
        _moviesFetcher.sink.add(itemModel);
      } else {
        fetchAllMoviesFromDatabase();
        //_moviesFetcher.sink.addError('No Internet Connection');
      }
    });
  }

  //if device is offline ,fetch movies from database
  fetchAllMoviesFromDatabase() async {
    var favMovies = (await _localRepository.fetchAllMoviesFromDatabase());
    _moviesFetcher.sink.add(mapFavMoviesToItemModel(favMovies));
  }

  //create mapper to map favMovies to ItemModel
  ItemModel mapFavMoviesToItemModel(List<FavMovies> favMovies) {
    List<Result> results = [];
    for (var element in favMovies) {
      results.add(Result.mapFromDatabase(
          id: element.id,
          title: element.title,
          posterPath: element.posterPath,
          originalLanguage: element.originalLanguage,
          releaseDate: element.releaseDate));
    }
    return ItemModel(results: results);
  }

  searchMoviesFromQuery(String query) async {
    ItemModel itemModel = await _repository.searchMoviesFromQuery(query);
    _moviesFetcher.sink.add(itemModel);
  }

  Future<FavMovies> isFavoriteMovie(int? id) async {
    return await _localRepository.isFavMovie(id);
  }

  dispose() {
    _moviesFetcher.close();
  }
}
