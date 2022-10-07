import 'package:floor/floor.dart';

@entity
class FavMovies {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String originalLanguage;
  final String description;

  FavMovies({required this.id, required this.title, required this.posterPath, required this.releaseDate,
      required this.originalLanguage,required this.description});
}
