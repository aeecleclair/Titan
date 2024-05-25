import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/cinema/class/the_movie_db_genre.dart';
import 'package:myecl/tools/repository/repository.dart';

class TheMovieDBRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'cinema/movie/';

  Future<TheMovieDBMovie> getMovie(String movieId) async {
    return TheMovieDBMovie.fromJson(await getOne(movieId));
  }
}

final theMovieDBRepository = Provider<TheMovieDBRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return TheMovieDBRepository()..setToken(token);
});
