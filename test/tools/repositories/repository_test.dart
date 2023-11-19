import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/repository/repository.dart';

class MockClient extends Mock implements http.Client {}

class MockRepository extends Repository {}

class MockCacheManager extends Mock implements CacheManager {}

void main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  group('Testing getList', () {
    final client = MockClient();
    final repository = MockRepository();
    repository.initLogger();
    repository.cacheManager = MockCacheManager();

    test('getList returns a list of objects', () async {
      // Arrange
      final expectedList = [
        {'id': 1, 'name': 'Object 1'},
        {'id': 2, 'name': 'Object 2'},
        {'id': 3, 'name': 'Object 3'},
      ];
      final response = http.Response(
          '[{"id": 1, "name": "Object 1"}, {"id": 2, "name": "Object 2"}, {"id": 3, "name": "Object 3"}]',
          200);
      when(() => client.get(Uri.parse('${repository.host}${repository.ext}')))
          .thenAnswer((_) async => response);

      // Act
      final result = await repository.getList();
      print(result);

      // Assert
      expect(result, expectedList);
    });

  //   test('getList returns an empty list when server returns 404', () async {
  //     // Arrange
  //     final response = http.Response('Not Found', 404);
  //     when(() => client.get(Uri.parse('${repository.host}${repository.ext}')))
  //         .thenAnswer((_) async => response);

  //     // Act
  //     final result = await repository.getList();

  //     // Assert
  //     expect(result, []);
  //   });

  //   test('getList returns an empty list when an exception is thrown', () async {
  //     // Arrange
  //     when(() => client.get(Uri.parse('${repository.host}${repository.ext}')))
  //         .thenThrow(Exception('Error'));

  //     // Act
  //     final result = await repository.getList();

  //     // Assert
  //     expect(result, []);
  //   });
  // });

  // group('Testing getOne', () {
  //   final client = MockClient();
  //   final repository = MockRepository();
  //   test('getOne returns an object', () async {
  //     // Arrange
  //     final expectedObject = {'id': 1, 'name': 'Object 1'};
  //     final response = http.Response('{"id": 1, "name": "Object 1"}', 200);
  //     when(() => client.get(Uri.parse('${repository.host}${repository.ext}1')))
  //         .thenAnswer((_) async => response);

  //     // Act
  //     final result = await repository.getOne('1');

  //     // Assert
  //     expect(result, expectedObject);
  //   });

  //   test('getOne returns an empty object when server returns 404', () async {
  //     // Arrange
  //     final response = http.Response('Not Found', 404);
  //     when(() => client.get(Uri.parse('${repository.host}${repository.ext}1')))
  //         .thenAnswer((_) async => response);

  //     // Act
  //     final result = await repository.getOne('1');

  //     // Assert
  //     expect(result, {});
  //   });

  //   test('getOne returns an empty object when an exception is thrown',
  //       () async {
  //     // Arrange
  //     when(() => client.get(Uri.parse('${repository.host}${repository.ext}1')))
  //         .thenThrow(Exception('Error'));

  //     // Act
  //     final result = await repository.getOne('1');

  //     // Assert
  //     expect(result, {});
  //   });
  // });

  // group('Testing update', () {
  //   final client = MockClient();
  //   final repository = MockRepository();
  //   test('create returns an object', () async {
  //     // Arrange
  //     final expectedObject = {'id': 1, 'name': 'Object 1'};
  //     final response = http.Response('{"id": 1, "name": "Object 1"}', 201);
  //     when(() => client.post(Uri.parse(repository.host + repository.ext),
  //         headers: repository.headers,
  //         body: jsonEncode(expectedObject))).thenAnswer((_) async => response);

  //     // Act
  //     final result = await repository.create(expectedObject);

  //     // Assert
  //     expect(result, expectedObject);
  //   });

  //   test('create returns true when server returns 204', () async {
  //     // Arrange
  //     final response = http.Response('', 204);
  //     when(() => client.post(Uri.parse(repository.host + repository.ext),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenAnswer((_) async => response);

  //     // Act
  //     final result = await repository.create({});

  //     // Assert
  //     expect(result, true);
  //   });

  //   test(
  //       'create throws AppException when server returns 403 with expired token detail',
  //       () async {
  //     // Arrange
  //     final response = http.Response('{"detail": "Expired token"}', 403);
  //     when(() => client.post(Uri.parse(repository.host + repository.ext),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.create({}),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.tokenExpire &&
  //             e.message == 'Expired token')));
  //   });

  //   test('create throws AppException when server returns 403 with other detail',
  //       () async {
  //     // Arrange
  //     final response = http.Response('{"detail": "Other error"}', 403);
  //     when(() => client.post(Uri.parse(repository.host + repository.ext),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.create({}),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.notFound &&
  //             e.message == 'Other error')));
  //   });

  //   test('create throws AppException when server returns other status code',
  //       () async {
  //     // Arrange
  //     final response = http.Response('Not Found', 404);
  //     when(() => client.post(Uri.parse(repository.host + repository.ext),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.create({}),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.notFound &&
  //             e.message == 'Not Found')));
  //   });

  //   test('create throws AppException when an exception is thrown', () async {
  //     // Arrange
  //     when(() => client.post(Uri.parse(repository.host + repository.ext),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenThrow(Exception('Error'));

  //     // Act & Assert
  //     expect(
  //         () => repository.create({}),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.invalidData &&
  //             e.message == 'Error')));
  //   });
  // });

  // group('Testing update', () {
  //   final client = MockClient();
  //   final repository = MockRepository();
  //   test('update returns true', () async {
  //     // Arrange
  //     final expectedObject = {'id': 1, 'name': 'Object 1'};
  //     final response = http.Response('', 204);
  //     when(() => client.patch(Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers,
  //         body: jsonEncode(expectedObject))).thenAnswer((_) async => response);

  //     // Act
  //     final result = await repository.update(expectedObject, '1');

  //     // Assert
  //     expect(result, true);
  //   });

  //   test(
  //       'update throws AppException when server returns 403 with expired token detail',
  //       () async {
  //     // Arrange
  //     final response = http.Response('{"detail": "Expired token"}', 403);
  //     when(() => client.patch(Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.update({}, '1'),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.tokenExpire &&
  //             e.message == 'Expired token')));
  //   });

  //   test('update throws AppException when server returns 403 with other detail',
  //       () async {
  //     // Arrange
  //     final response = http.Response('{"detail": "Other error"}', 403);
  //     when(() => client.patch(Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.update({}, '1'),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.notFound &&
  //             e.message == 'Other error')));
  //   });

  //   test('update throws AppException when server returns other status code',
  //       () async {
  //     // Arrange
  //     final response = http.Response('Not Found', 404);
  //     when(() => client.patch(Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.update({}, '1'),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.notFound &&
  //             e.message == 'Not Found')));
  //   });

  //   test('update throws AppException when an exception is thrown', () async {
  //     // Arrange
  //     when(() => client.patch(Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers,
  //         body: jsonEncode({}))).thenThrow(Exception('Error'));

  //     // Act & Assert
  //     expect(
  //         () => repository.update({}, '1'),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.invalidData &&
  //             e.message == 'Error')));
  //   });
  // });

  // group('Testing delete', () {
  //   final client = MockClient();
  //   final repository = MockRepository();

  //   test('delete returns true', () async {
  //     // Arrange
  //     final response = http.Response('', 204);
  //     when(() => client.delete(
  //         Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers)).thenAnswer((_) async => response);

  //     // Act
  //     final result = await repository.delete('1');

  //     // Assert
  //     expect(result, true);
  //   });

  //   test(
  //       'delete throws AppException when server returns 403 with expired token detail',
  //       () async {
  //     // Arrange
  //     final response = http.Response('{"detail": "Expired token"}', 403);
  //     when(() => client.delete(
  //         Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers)).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.delete('1'),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.tokenExpire &&
  //             e.message == 'Expired token')));
  //   });

  //   test('delete throws AppException when server returns 403 with other detail',
  //       () async {
  //     // Arrange
  //     final response = http.Response('{"detail": "Other error"}', 403);
  //     when(() => client.delete(
  //         Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers)).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.delete('1'),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.notFound &&
  //             e.message == 'Other error')));
  //   });

  //   test('delete throws AppException when server returns other status code',
  //       () async {
  //     // Arrange
  //     final response = http.Response('Not Found', 404);
  //     when(() => client.delete(
  //         Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers)).thenAnswer((_) async => response);

  //     // Act & Assert
  //     expect(
  //         () => repository.delete('1'),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.notFound &&
  //             e.message == 'Not Found')));
  //   });

  //   test('delete throws AppException when an exception is thrown', () async {
  //     // Arrange
  //     when(() => client.delete(
  //         Uri.parse('${repository.host}${repository.ext}1'),
  //         headers: repository.headers)).thenThrow(Exception('Error'));

  //     // Act & Assert
  //     expect(
  //         () => repository.delete('1'),
  //         throwsA(predicate((e) =>
  //             e is AppException &&
  //             e.type == ErrorType.invalidData &&
  //             e.message == 'Error')));
  //   });
  });
}
