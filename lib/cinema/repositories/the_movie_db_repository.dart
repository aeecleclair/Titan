import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/cinema/class/the_movie_db_genre.dart';
import 'package:titan/tools/repository/repository.dart';

class TheMovieDBRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'cinema/themoviedb/';

  Future<TheMovieDBMovie> getMovie(String movieId) async {
    return TheMovieDBMovie.fromJson(await getOne(movieId));
  }
}

final theMovieDBRepository = Provider<TheMovieDBRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return TheMovieDBRepository()..setToken(token);
});
