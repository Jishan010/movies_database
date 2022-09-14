import 'dart:async';
import 'package:movies_database/src/data/movie_search_api_service.dart';
import 'package:movies_database/src/database/fav_movies.dart';
import '../data/movies_api_service.dart';
import '../database/app_database.dart';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiDatSource {
  final _apiKey = 'a9d3771ee8051284ae7c6519283c76a2';

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    //todo inject with depedency injection framework
    MovieApiService service = MovieApiService.create();
    final response = await service.getPopularMovies(_apiKey);
    print(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    MovieApiService service = MovieApiService.create();
    final response = await service.getMovieDetails(movieId, _apiKey);
    print(response.body);
    if (response.statusCode == 200) {
      return TrailerModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load trailers');
    }
  }

  //https://api.themovied454.04b.org/3/search/movie?api_key={api_key}&query=Jack+Reacher
  Future<ItemModel> fetchMoviesBySearcgQuery(String query) async {
   MovieSearchApiService service = MovieSearchApiService.create();
    final response = await service.searchMovies(_apiKey, query);
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load trailers');
    }
  }

  //fetch movies from database
  Future<List<FavMovies>> fetchAllMoviesFromDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('movies.db').build();
    final favMoviesDao = database.favMoviesDao;
    return await favMoviesDao.findAllFavMoviesList();
  }

  //function to check if movie is fav
  Future<FavMovies> isFavMovie(int? id) async {
    final database = await $FloorAppDatabase.databaseBuilder('movies.db').build();
    final favMoviesDao = database.favMoviesDao;
    final favMovies = await favMoviesDao.findMovieById(id!);
    if (favMovies != null) {
      return favMovies;
    } else {
      return FavMovies(id, '', '', '', '', 0);
    }
  }



}
