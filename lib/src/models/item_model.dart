class ItemModel {
  int? _page;
  int? _totalResults;
  int? _totalPages;
  List<Result> _results = [];

  ItemModel({
    int? page,
    int? totalResults,
    int? totalPages,
    List<Result>? results,
  }) {
    _page = page;
    _totalResults = totalResults;
    _totalPages = totalPages;
    _results = results ?? [];
  }

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    List<Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Result result = Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<Result> get results => _results;

  int? get totalPages => _totalPages;

  int? get totalResults => _totalResults;

  int? get page => _page;
}

class Result {
  int? _voteCount;
  int? _id;
  bool? _video;
  var _voteAverage;
  String? _title;
  double? _popularity;
  String? _posterPath;
  String? _originalLanguage;
  String? _originalTitle;
  List<int> _genreIds = [];
  String? _backdropPath;
  bool? _adult;
  String? _overview;
  String? _releaseDate;

  Result.mapFromDatabase({
    int? voteCount,
    int? id,
    bool? video,
    var voteAverage,
    String? title,
    double? popularity,
    String? posterPath,
    String? originalLanguage,
    String? originalTitle,
    List<int>? genreIds,
    String? backdropPath,
    bool? adult,
    String? overview,
    String? releaseDate,
  }) {
    _voteCount = voteCount;
    _id = id;
    _video = video;
    _voteAverage = voteAverage;
    _title = title;
    _popularity = popularity;
    _posterPath = posterPath;
    _originalLanguage = originalLanguage;
    _originalTitle = originalTitle;
    _genreIds = genreIds ?? [];
    _backdropPath = backdropPath;
    _adult = adult;
    _overview = overview;
    _releaseDate = releaseDate;
  }

  Result(result) {
    _voteCount = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _voteAverage = result['vote_average'];
    _title = result['title'];
    _popularity = result['popularity'];
    _posterPath = result['poster_path'];
    _originalLanguage = result['original_language'];
    _originalTitle = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genreIds.add(result['genre_ids'][i]);
    }
    _backdropPath = result['backdrop_path'];
    _adult = result['adult'];
    _overview = result['overview'];
    _releaseDate = result['release_date'];
  }

  String? get releaseDate => _releaseDate;

  String? get overview => _overview;

  bool? get adult => _adult;

  String? get backdropPath => _backdropPath;

  List<int> get genreIds => _genreIds;

  String? get originalTitle => _originalTitle;

  String? get originalLanguage => _originalLanguage;

  String? get posterPath => _posterPath;

  double? get popularity => _popularity;

  String? get title => _title;

  num? get voteAverage => _voteAverage;

  bool? get video => _video;

  int? get id => _id;

  int? get voteCount => _voteCount;
}