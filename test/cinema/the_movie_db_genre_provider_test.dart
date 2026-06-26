import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/cinema/providers/the_movie_db_genre_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class MockTheMovieDBRepository extends Mock implements Openapi {}

void main() {
  group('TheMovieDBGenreNotifier', () {
    late MockTheMovieDBRepository mockRepository;
    late ProviderContainer container;
    late TheMovieDBGenreNotifier provider;
    final movie = TheMovieDB(
      genres: [],
      overview: '',
      posterPath: '',
      title: '',
      runtime: 0,
      tagline: '',
    );

    setUp(() async {
      mockRepository = MockTheMovieDBRepository();
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(theMovieDBMovieProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadMovie returns expected data', () async {
      when(
        () => mockRepository.cinemaThemoviedbThemoviedbIdGet(
          themoviedbId: any(named: 'themoviedbId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), movie),
      );

      final result = await provider.loadMovie('1');

      expect(result.maybeWhen(data: (data) => data, orElse: () => null), movie);
    });

    test('loadMovie handles error', () async {
      when(
        () => mockRepository.cinemaThemoviedbThemoviedbIdGet(
          themoviedbId: any(named: 'themoviedbId'),
        ),
      ).thenThrow(Exception('Failed to load movie'));

      final result = await provider.loadMovie('1');

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });
  });
}
