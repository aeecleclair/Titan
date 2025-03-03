import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/cinema/providers/the_movie_db_genre_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockTheMovieDBRepository extends Mock implements Openapi {}

void main() {
  group('TheMovieDBGenreNotifier', () {
    late MockTheMovieDBRepository mockRepository;
    late TheMovieDBGenreNotifier provider;
    final movie = TheMovieDB(
      genres: [],
      overview: '',
      posterPath: '',
      title: '',
      runtime: 0,
      tagline: '',
    );

    setUp(() {
      mockRepository = MockTheMovieDBRepository();
      provider = TheMovieDBGenreNotifier(theMoviesDBRepository: mockRepository);
    });

    test('loadMovie returns expected data', () async {
      when(
        () => mockRepository.cinemaThemoviedbThemoviedbIdGet(
          themoviedbId: any(named: 'themoviedbId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          movie,
        ),
      );

      final result = await provider.loadMovie('1');

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => null,
        ),
        movie,
      );
    });

    test('loadMovie handles error', () async {
      when(
        () => mockRepository.cinemaThemoviedbThemoviedbIdGet(
          themoviedbId: any(named: 'themoviedbId'),
        ),
      ).thenThrow(Exception('Failed to load movie'));

      final result = await provider.loadMovie('1');

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });
  });
}
