// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$MovieApiService extends MovieApiService {
  _$MovieApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MovieApiService;

  @override
  Future<Response<dynamic>> getPopularMovies(String apiKey) {
    final $url = '/movie/popular';
    final $params = <String, dynamic>{'api_key': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMovieDetails(int? movieId, String apiKey) {
    final $url = '/movie/${movieId}/videos';
    final $params = <String, dynamic>{'api_key': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> searchMovies(String apiKey, String query) {
    final $url = '/search/movie';
    final $params = <String, dynamic>{'api_key': apiKey, 'query': query};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
