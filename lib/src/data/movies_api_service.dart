import 'package:chopper/chopper.dart';

// This is necessary for the generator to work.
part 'movies_api_service.chopper.dart';


@ChopperApi(baseUrl: "/")
abstract class MovieApiService extends ChopperService {
  static MovieApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://api.themoviedb.org/3',
      services: [
        _$MovieApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );
    return _$MovieApiService(client);
  }

  @Get(path: 'movie/popular')
  Future<Response> getPopularMovies(
    @Query('api_key') String apiKey
  );

  @Get(path: 'movie/{movie_id}/videos')
  Future<Response> getMovieDetails(
    @Path('movie_id') int movieId,
    @Query('api_key') String apiKey,
  );

  @Get(path: 'search/movie')
  Future<Response> searchMovies(
      @Query('api_key') String apiKey,
      @Query('query') String query
      );
}