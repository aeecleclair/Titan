import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myecl/cinema/class/the_movie_db_genre.dart';
import 'package:myecl/cinema/class/the_movie_db_search_result.dart';
import 'package:myecl/tools/repository/repository.dart';

class TheMovieDBRepository extends Repository {
  @override
  // ignore: overridden_fields
  final String host = 'https://api.themoviedb.org/3/';
  final String apiKey = dotenv.env['THE_MOVIE_DB_API']!;

  Future<List<TheMovieDBSearchResult>> searchMovie(String id) async {
    final resp = await getOne("",
        suffix:
            "find/$id?api_key=$apiKey&language=fr-FR&external_source=imdb_id");
    if (resp["movie_results"] != null) {
      return (resp["movie_results"] as List<dynamic>)
          .map((e) => TheMovieDBSearchResult.fromJson(e))
          .toList();
    }
    return <TheMovieDBSearchResult>[];
  }

  Future<List<TheMovieDBGenre>> getAllGenre() async {
    final resp = await getOne("",
        suffix: "genre/movie/list?api_key=$apiKey&language=fr-FR");
    if (resp["genres"] != null) {
      return (resp["genres"] as List<dynamic>)
          .map((e) => TheMovieDBGenre.fromJson(e))
          .toList();
    }
    return <TheMovieDBGenre>[];
  }
}
