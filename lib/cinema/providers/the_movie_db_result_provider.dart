import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/cinema/class/the_movie_db_search_result.dart';
import 'package:myecl/cinema/repositories/the_movie_db_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TheMovieDBResultNotifier extends ListNotifier<TheMovieDBSearchResult> {
  TheMovieDBRepository theMoviesDBRepository = TheMovieDBRepository();
  TheMovieDBResultNotifier({required String token})
      : super(const AsyncValue.loading()) {
    theMoviesDBRepository.setToken(token);
  }

  Future<AsyncValue<List<TheMovieDBSearchResult>>> loadMovies(String query) async {
    return await loadList(() => theMoviesDBRepository.searchMovie(query));
  }
}

final theMovieDBResultProvider =
    StateNotifierProvider<TheMovieDBResultNotifier, AsyncValue<List<TheMovieDBSearchResult>>>((ref) {
  final token = ref.watch(tokenProvider);
  TheMovieDBResultNotifier notifier = TheMovieDBResultNotifier(token: token);
  return notifier;
});
