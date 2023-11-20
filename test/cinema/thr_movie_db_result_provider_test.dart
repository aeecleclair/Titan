import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/cinema/class/the_movie_db_search_result.dart';
import 'package:myecl/cinema/providers/the_movie_db_result_provider.dart';
import 'package:myecl/cinema/repositories/the_movie_db_repository.dart';

class MockTheMovieDBRepository extends Mock implements TheMovieDBRepository {}

void main() {
  group('TheMovieDBResultNotifier', () {
    test('TheMovieDBResultNotifier initializes with loading state', () {
      final repository = MockTheMovieDBRepository();
      final notifier =
          TheMovieDBResultNotifier(theMoviesDBRepository: repository);
      expect(notifier.state, isA<AsyncLoading>());
    });

    test('loadMovies returns a list of search results', () async {
      final repository = MockTheMovieDBRepository();
      final notifier =
          TheMovieDBResultNotifier(theMoviesDBRepository: repository);
      const query = 'test';
      final expectedResults = [
        TheMovieDBSearchResult.empty(),
        TheMovieDBSearchResult.empty(),
      ];
      when(() => repository.searchMovie(query))
          .thenAnswer((_) async => expectedResults);
      final result = await notifier.loadMovies(query);
      expect(
          result.when(
            data: (data) => data,
            loading: () => null,
            error: (error, stack) => null,
          ),
          isA<List<TheMovieDBSearchResult>>());
    });

    test('loadMovies returns an error when the repository throws an error',
        () async {
      final repository = MockTheMovieDBRepository();
      final notifier =
          TheMovieDBResultNotifier(theMoviesDBRepository: repository);
      const query = 'test';
      const expectedError = 'Error';
      when(() => repository.searchMovie(query)).thenThrow(expectedError);
      final result = await notifier.loadMovies(query);
      expect(result.hasError, true);
      expect(result.error, expectedError);
    });
  });
}
