import 'dart:async';
import 'package:movies_database/src/database/fav_movies.dart';
import '../data/movies_api_service.dart';
import '../database/fav_movies_dao.dart';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiDataSource {
  final _apiKey = 'a9d3771ee8051284ae7c6519283c76a2';
  late MovieApiService service;
  late FavMoviesDao favMoviesDao;

  MovieApiDataSource(this.service, this.favMoviesDao);

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response = await service.getPopularMovies(_apiKey);
    print(response.body);
    if (response.statusCode == 200) {
      print("${response.statusCode}");
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int? movieId) async {
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
    return await favMoviesDao.findAllFavMoviesList();
  }

  //function to check if movie is fav
  Future<FavMovies> isFavMovie(int? id) async {
    final favMovies = await favMoviesDao.findMovieById(id!);
    if (favMovies != null) {
      return favMovies;
    } else {
      return FavMovies(id: id, title: "", posterPath: "", releaseDate: "", originalLanguage: "", description: "");
    }
  }

  //function to add movie to fav
  Future<bool> addMovieToFav(FavMovies favMovies) async {
    favMoviesDao.insertFavMovies(favMovies);
    return true;
  }

  //function to delete movie from fav
  Future<bool> deleteMovieFromFav(int? id) async {
    final movie = await favMoviesDao.findMovieById(id!);
    if (movie != null) {
      favMoviesDao.deleteFavMovies(movie.id);
      return true;
    }
    return false;
  }
}
