import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = 'a9d3771ee8051284ae7c6519283c76a2';
  final _baseUrl = "http://api.themoviedb.org/3/movie";
  final _baseUrlForSearch = "https://api.themoviedb.org/3/search";

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response =
        await client.get(Uri.parse("$_baseUrl/popular?api_key=$_apiKey"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response = await client
        .get(Uri.parse("$_baseUrl/$movieId/videos?api_key=$_apiKey"));

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }

  //https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher
  Future<ItemModel> fetchMoviesBySearcgQuery(String query) async {
    final response = await client.get(Uri.parse("$_baseUrlForSearch/movie?api_key=$_apiKey&query=$query"));
    print( "$_baseUrl/movie?api_key=$_apiKey&query=$query");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }




}
