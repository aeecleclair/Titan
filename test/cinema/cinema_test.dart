import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/cinema/class/session.dart';
import 'package:titan/cinema/class/the_movie_db_genre.dart';
import 'package:titan/cinema/class/the_movie_db_search_result.dart';
import 'package:titan/cinema/repositories/session_repository.dart';

class MockSessionRepository extends Mock implements SessionRepository {}

void main() {
  group('Testing Session class', () {
    test('Should return a Session', () {
      final session = Session.empty();
      expect(session, isA<Session>());
    });

    test('Should print properly with toString()', () {
      final session = Session(
        id: "1",
        name: "Session 1",
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
        duration: 120,
        overview: "Overview",
        genre: "Genre",
        tagline: "Tagline",
      );
      expect(
        session.toString(),
        "Session{id: 1, name: Session 1, start: 2021-01-01 00:00:00.000Z, duration: 120, overview: Overview, genre: Genre, tagline: Tagline}",
      );
    });

    test('Should return a Session with the correct values', () {
      final session = Session.empty();
      expect(session.id, equals(''));
      expect(session.name, equals(''));
      expect(session.start, isA<DateTime>());
      expect(session.duration, equals(0));
      expect(session.overview, equals(""));
      expect(session.genre, equals(""));
      expect(session.tagline, equals(""));
    });

    test('Should update with new information', () {
      final session = Session.empty();
      Session newSession = session.copyWith(id: "1");
      expect(newSession, isA<Session>());
      expect(newSession.id, equals("1"));
      newSession = session.copyWith(name: "Session 1");
      expect(newSession.name, equals("Session 1"));
      newSession = session.copyWith(
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(
        newSession.start,
        equals(DateTime.parse("2021-01-01T00:00:00.000Z")),
      );
      newSession = session.copyWith(duration: 120);
      expect(newSession.duration, equals(120));
      newSession = session.copyWith(overview: "Overview");
      expect(newSession.overview, equals("Overview"));
      newSession = session.copyWith(genre: "Genre");
      expect(newSession.genre, equals("Genre"));
      newSession = session.copyWith(tagline: "Tagline");
      expect(newSession.tagline, equals("Tagline"));
    });

    test('Should parse a Session from json', () {
      final start = DateTime.utc(2021, 1, 1);
      final session = Session.fromJson({
        "id": "1",
        "name": "Session 1",
        "start": start.toIso8601String(),
        "duration": 120,
        "overview": "Overview",
        "genre": "Genre",
        "tagline": "Tagline",
      });
      expect(session, isA<Session>());
      expect(session.id, equals("1"));
      expect(session.name, equals("Session 1"));
      expect(session.start, equals(start.toLocal()));
      expect(session.duration, equals(120));
      expect(session.overview, equals("Overview"));
      expect(session.genre, equals("Genre"));
      expect(session.tagline, equals("Tagline"));
    });

    test('Should return a json from a Session', () {
      final session = Session.fromJson({
        "id": "1",
        "name": "Session 1",
        "start": "2021-01-01T00:00:00.000Z",
        "duration": 120,
        "overview": "Overview",
        "genre": "Genre",
        "tagline": "Tagline",
      });
      expect(
        session.toJson(),
        equals({
          "id": "1",
          "name": "Session 1",
          "start": "2021-01-01T00:00:00.000Z",
          "duration": 120,
          "overview": "Overview",
          "genre": "Genre",
          "tagline": "Tagline",
        }),
      );
    });
  });

  group('TheMovieDBMovie', () {
    test('fromJson should parse json correctly', () {
      final json = {
        'genres': [
          {'name': 'Action'},
          {'name': 'Adventure'},
          {'name': 'Sci-Fi'},
        ],
        'overview': 'A great movie',
        'poster_path': '/poster.jpg',
        'title': 'The Movie',
        'runtime': 120,
        'tagline': 'The best movie ever',
      };

      final movie = TheMovieDBMovie.fromJson(json);

      expect(movie.genres, ['Action', 'Adventure', 'Sci-Fi']);
      expect(movie.overview, 'A great movie');
      expect(movie.posterUrl, 'https://image.tmdb.org/t/p/w500/poster.jpg');
      expect(movie.title, 'The Movie');
      expect(movie.runtime, 120);
      expect(movie.tagline, 'The best movie ever');
    });

    test('toJson should convert object to json', () {
      final movie = TheMovieDBMovie(
        genres: ['Action', 'Adventure', 'Sci-Fi'],
        overview: 'A great movie',
        posterUrl: 'https://image.tmdb.org/t/p/w500/poster.jpg',
        title: 'The Movie',
        runtime: 120,
        tagline: 'The best movie ever',
      );

      final json = movie.toJson();

      expect(json['genres'], ['Action', 'Adventure', 'Sci-Fi']);
      expect(json['overview'], 'A great movie');
      expect(json['poster_path'], 'https://image.tmdb.org/t/p/w500/poster.jpg');
      expect(json['title'], 'The Movie');
      expect(json['runtime'], 120);
      expect(json['tagline'], 'The best movie ever');
    });

    test('empty should return an empty object', () {
      final movie = TheMovieDBMovie.empty();

      expect(movie.genres, []);
      expect(movie.overview, '');
      expect(movie.posterUrl, '');
      expect(movie.title, '');
      expect(movie.runtime, 0);
      expect(movie.tagline, '');
    });

    test('return correct String with toString()', () {
      final movie = TheMovieDBMovie(
        genres: ['Action', 'Adventure', 'Sci-Fi'],
        overview: 'A great movie',
        posterUrl: 'https://image.tmdb.org/t/p/w500/poster.jpg',
        title: 'The Movie',
        runtime: 120,
        tagline: 'The best movie ever',
      );

      expect(
        movie.toString(),
        'TheMovieDBMovie{genres: [Action, Adventure, Sci-Fi], overview: A great movie, posterUrl: https://image.tmdb.org/t/p/w500/poster.jpg, title: The Movie, runtime: 120, tagline: The best movie ever}',
      );
    });
  });

  group('TheMovieDBMovieSearchResult', () {
    test('TheMovieDBSearchResult.fromJson should parse json correctly', () {
      final json = {
        'poster_path': '/poster.jpg',
        'overview': 'A great movie',
        'genre_ids': [1, 2, 3],
        'id': 123,
        'title': 'The Movie',
      };

      final result = TheMovieDBSearchResult.fromJson(json);

      expect(result.posterUrl, 'https://image.tmdb.org/t/p/w500/poster.jpg');
      expect(result.overview, 'A great movie');
      expect(result.genreIds, [1, 2, 3]);
      expect(result.genreNames, []);
      expect(result.id, '123');
      expect(result.title, 'The Movie');
    });

    test(
      'TheMovieDBSearchResult.toJson should convert object to json correctly',
      () {
        final result = TheMovieDBSearchResult(
          posterUrl: 'https://image.tmdb.org/t/p/w500/poster.jpg',
          overview: 'A great movie',
          genreIds: [1, 2, 3],
          genreNames: [],
          id: '123',
          title: 'The Movie',
        );

        final json = result.toJson();

        expect(
          json['poster_path'],
          'https://image.tmdb.org/t/p/w500/poster.jpg',
        );
        expect(json['overview'], 'A great movie');
        expect(json['genre_ids'], [1, 2, 3]);
        expect(json['id'], '123');
        expect(json['title'], 'The Movie');
      },
    );

    test('TheMovieDBSearchResult.empty should return an empty object', () {
      final result = TheMovieDBSearchResult.empty();

      expect(result.posterUrl, '');
      expect(result.overview, '');
      expect(result.genreIds, []);
      expect(result.genreNames, []);
      expect(result.id, '');
      expect(result.title, '');
    });

    test('TheMovieDBSearchResult.toString should return correct String', () {
      final result = TheMovieDBSearchResult(
        posterUrl: 'https://image.tmdb.org/t/p/w500/poster.jpg',
        overview: 'A great movie',
        genreIds: [1, 2, 3],
        genreNames: [],
        id: '123',
        title: 'The Movie',
      );

      expect(
        result.toString(),
        'TheMovieDBSearchResult(posterUrl: https://image.tmdb.org/t/p/w500/poster.jpg, overview: A great movie, genreIds: [1, 2, 3], genreNames: [], id: 123, title: The Movie)',
      );
    });
  });
}
