import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/class/the_movie_db_genre.dart';
import 'package:myecl/cinema/class/the_movie_db_search_result.dart';
import 'package:myecl/tools/repository/repository.dart';

import '../../auth/providers/openid_provider.dart';

class TheMovieDBRepository extends Repository {
  @override
  // ignore: overridden_fields
  final String host = 'https://api.themoviedb.org/3/';
  final String apiKey = dotenv.env['THE_MOVIE_DB_API']!;

  Future<List<TheMovieDBSearchResult>> searchMovie(String id) async {
    final resp = await getOne(
      "",
      suffix: "find/$id?api_key=$apiKey&language=fr-FR&external_source=imdb_id",
    );
    if (resp["movie_results"] != null) {
      return (resp["movie_results"] as List<dynamic>)
          .map((e) => TheMovieDBSearchResult.fromJson(e))
          .toList();
    }
    return <TheMovieDBSearchResult>[];
  }

  Future<TheMovieDBMovie> getMovie(String id) async {
    return TheMovieDBMovie.fromJson(
      await getOne("movie/$id", suffix: "?api_key=$apiKey&language=fr-FR"),
    );
  }
}

final theMovieDBRepository = Provider<TheMovieDBRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return TheMovieDBRepository()..setToken(token);
});
