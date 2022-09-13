import 'package:chopper/chopper.dart';

// This is necessary for the generator to work.
part 'movie_search_api_service.chopper.dart';

@ChopperApi(baseUrl: "/")
abstract class MovieSearchApiService extends ChopperService {
  static MovieSearchApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://api.themoviedb.org/3',
      services: [
        _$MovieSearchApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );
    return _$MovieSearchApiService(client);
  }

  @Get(path: 'search/movie')
  Future<Response> searchMovies(
    @Query('api_key') String apiKey,
    @Query('query') String query
  );
}