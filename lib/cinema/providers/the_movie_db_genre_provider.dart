import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/cinema/class/the_movie_db_genre.dart';
import 'package:myecl/cinema/repositories/the_movie_db_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class TheMovieDBGenreNotifier extends SingleNotifier<TheMovieDBMovie> {
  TheMovieDBRepository theMoviesDBRepository = TheMovieDBRepository();
  TheMovieDBGenreNotifier({required String token})
      : super(const AsyncValue.loading()) {
    theMoviesDBRepository.setToken(token);
  }

  Future<AsyncValue<TheMovieDBMovie>> loadMovie(String id) async {
    return await load(() => theMoviesDBRepository.getMovie(id));
  }
}

final theMovieDBMovieProvider =
    StateNotifierProvider<TheMovieDBGenreNotifier, AsyncValue<TheMovieDBMovie>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  TheMovieDBGenreNotifier notifier = TheMovieDBGenreNotifier(token: token);
  return notifier;
});
