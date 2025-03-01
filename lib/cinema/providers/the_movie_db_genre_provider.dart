import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';

class TheMovieDBGenreNotifier extends SingleNotifier2<TheMovieDB> {
  final Openapi theMoviesDBRepository;
  TheMovieDBGenreNotifier({required this.theMoviesDBRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<TheMovieDB>> loadMovie(String id) async {
    return await load(() => theMoviesDBRepository
        .cinemaThemoviedbThemoviedbIdGet(themoviedbId: id));
  }
}

final theMovieDBMovieProvider =
    StateNotifierProvider<TheMovieDBGenreNotifier, AsyncValue<TheMovieDB>>(
        (ref) {
  final theMovieDB = ref.watch(repositoryProvider);
  TheMovieDBGenreNotifier notifier =
      TheMovieDBGenreNotifier(theMoviesDBRepository: theMovieDB);
  return notifier;
});
