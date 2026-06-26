import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TheMovieDBGenreNotifier extends SingleNotifierAPI<TheMovieDB> {
  Openapi get theMoviesDBRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<TheMovieDB> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<TheMovieDB>> loadMovie(String id) async {
    return await load(
      () => theMoviesDBRepository.cinemaThemoviedbThemoviedbIdGet(
        themoviedbId: id,
      ),
    );
  }
}

final theMovieDBMovieProvider =
    NotifierProvider<TheMovieDBGenreNotifier, AsyncValue<TheMovieDB>>(
      () => TheMovieDBGenreNotifier(),
    );
