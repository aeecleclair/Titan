import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/class/the_movie_db_genre.dart';
import 'package:myecl/cinema/repositories/the_movie_db_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class TheMovieDBGenreNotifier extends SingleNotifier<TheMovieDBMovie> {
  final TheMovieDBRepository theMoviesDBRepository;
  TheMovieDBGenreNotifier({required this.theMoviesDBRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<TheMovieDBMovie>> loadMovie(String id) async {
    return await load(() => theMoviesDBRepository.getMovie(id));
  }
}

final theMovieDBMovieProvider =
    StateNotifierProvider<TheMovieDBGenreNotifier, AsyncValue<TheMovieDBMovie>>(
        (ref) {
  final theMovieDB = ref.watch(theMovieDBRepository);
  TheMovieDBGenreNotifier notifier =
      TheMovieDBGenreNotifier(theMoviesDBRepository: theMovieDB);
  return notifier;
});
