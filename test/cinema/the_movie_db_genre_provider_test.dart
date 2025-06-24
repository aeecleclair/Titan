import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/cinema/class/the_movie_db_genre.dart';
import 'package:titan/cinema/providers/the_movie_db_genre_provider.dart';
import 'package:titan/cinema/repositories/the_movie_db_repository.dart';
import 'package:titan/tools/exception.dart';

class MockTheMovieDBRepository extends Mock implements TheMovieDBRepository {}

void main() {
  group('TheMovieDBGenreNotifier', () {
    late TheMovieDBRepository theMovieDBRepository;
    late TheMovieDBGenreNotifier notifier;
    test('loadMovie returns AsyncValue with movie data', () async {
      theMovieDBRepository = MockTheMovieDBRepository();
      when(
        () => theMovieDBRepository.getMovie(any()),
      ).thenAnswer((_) async => TheMovieDBMovie.empty());
      notifier = TheMovieDBGenreNotifier(
        theMoviesDBRepository: theMovieDBRepository,
      );
      const movieId = '123';
      final result = await notifier.loadMovie(movieId);

      expect(
        result.when(
          data: (data) => data,
          loading: () => null,
          error: (error, stack) => null,
        ),
        isA<TheMovieDBMovie>(),
      );
    });

    test(
      'loadMovie returns AsyncValue with error when movie not found',
      () async {
        theMovieDBRepository = MockTheMovieDBRepository();
        when(
          () => theMovieDBRepository.getMovie(any()),
        ).thenThrow((_) async => AppException(ErrorType.notFound, 'Not found'));
        notifier = TheMovieDBGenreNotifier(
          theMoviesDBRepository: theMovieDBRepository,
        );
        const movieId = 'invalid_id';
        final result = await notifier.loadMovie(movieId);

        expect(result, isA<AsyncError>());
      },
    );
  });
}
