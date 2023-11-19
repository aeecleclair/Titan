import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/class/the_movie_db_search_result.dart';
import 'package:myecl/cinema/repositories/the_movie_db_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TheMovieDBResultNotifier extends ListNotifier<TheMovieDBSearchResult> {
  final TheMovieDBRepository theMoviesDBRepository;
  TheMovieDBResultNotifier({required this.theMoviesDBRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<TheMovieDBSearchResult>>> loadMovies(
      String query) async {
    return await loadList(() => theMoviesDBRepository.searchMovie(query));
  }
}

final theMovieDBResultProvider = StateNotifierProvider<TheMovieDBResultNotifier,
    AsyncValue<List<TheMovieDBSearchResult>>>((ref) {
  final theMovieDB = ref.watch(theMovieDBRepository);
  TheMovieDBResultNotifier notifier =
      TheMovieDBResultNotifier(theMoviesDBRepository: theMovieDB);
  return notifier;
});
