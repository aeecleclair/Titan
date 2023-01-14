import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/cinema/class/the_movie_db_genre.dart';
import 'package:myecl/cinema/repositories/the_movie_db_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TheMovieDBGenreNotifier extends ListNotifier<TheMovieDBGenre> {
  TheMovieDBRepository theMoviesDBRepository = TheMovieDBRepository();
  TheMovieDBGenreNotifier({required String token})
      : super(const AsyncValue.loading()) {
    theMoviesDBRepository.setToken(token);
  }

  Future<AsyncValue<List<TheMovieDBGenre>>> loadGenres() async {
    return await loadList(theMoviesDBRepository.getAllGenre);
  }
}

final theMovieDBGenreProvider = StateNotifierProvider<TheMovieDBGenreNotifier,
    AsyncValue<List<TheMovieDBGenre>>>((ref) {
  final token = ref.watch(tokenProvider);
  TheMovieDBGenreNotifier notifier = TheMovieDBGenreNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadGenres();
  });
  return notifier;
});
