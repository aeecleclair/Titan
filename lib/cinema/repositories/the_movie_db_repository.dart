import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/class/the_movie_db_genre.dart';
import 'package:myecl/tools/repository/repository.dart';

class TheMovieDBRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'cinema/themoviedb/';

  TheMovieDBRepository(super.ref);

  Future<TheMovieDBMovie> getMovie(String movieId) async {
    return TheMovieDBMovie.fromJson(await getOne(movieId));
  }
}

final theMovieDBRepository = Provider<TheMovieDBRepository>((ref) {
  return TheMovieDBRepository(ref);
});
