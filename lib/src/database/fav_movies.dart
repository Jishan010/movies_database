import 'package:floor/floor.dart';

@entity
class FavMovies {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String originalLanguage;
  final int isFav;

  FavMovies(this.id, this.title, this.posterPath, this.releaseDate,
      this.originalLanguage,this.isFav);
}
