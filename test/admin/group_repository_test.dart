// Unit tests for GroupRepository

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/admin/repositories/group_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('GroupRepository', () {
    WidgetsFlutterBinding.ensureInitialized();
    final mockHttpClient = MockHttpClient();
    final groupRepository = GroupRepository();

    test('getGroupList returns a list of SimpleGroup', () async {
      final expectedList = [
        SimpleGroup(id: '1', name: 'Group 1', description: ''),
        SimpleGroup(id: '2', name: 'Group 2', description: ''),
      ];
      when(() => mockHttpClient.get(Uri.parse('http://localhost:8000/groups/'),
          headers:
              any(named: 'headers'))).thenAnswer((_) async => http.Response(
          '[{"id": "1", "name": "Group 1", "description": ""}, {"id": "2", "name": "Group 2", "description": ""}]',
          200));
      final result = await groupRepository.getGroupList();
      expect(result, expectedList);
      verify(() => mockHttpClient.get(
          Uri.parse('http://localhost:8000/groups/'),
          headers: any(named: 'headers')));
    });
  });
}

// test('getGroup returns a Group', () async {
//   final expectedGroup = Group(id: '1', name: 'Group 1', members: []);
//   final expectedJson = {'id': '1', 'name': 'Group 1', 'members': []};
//   when(mockHttpClient.get(Uri.parse('http://localhost:8000/groups/1/'),
//           headers: anyNamed('headers')))
//       .thenAnswer((_) async =>
//           http.Response('{"id": "1", "name": "Group 1", "members": []}', 200));
//   final result = await groupRepository.getGroup('1');
//   expect(result, expectedGroup);
//   verify(mockHttpClient.get(Uri.parse('http://localhost:8000/groups/1/'),
//       headers: anyNamed('headers')));
// });

// test('deleteGroup returns true', () async {
//   when(mockHttpClient.delete(Uri.parse('http://localhost:8000/groups/1/'),
//           headers: anyNamed('headers')))
//       .thenAnswer((_) async => http.Response('', 204));
//   final result = await groupRepository.deleteGroup('1');
//   expect(result, true);
//   verify(mockHttpClient.delete(Uri.parse('http://localhost:8000/groups/1/'),
//       headers: anyNamed('headers')));
// });

// test('updateGroup returns true', () async {
//   final group = SimpleGroup(id: '1', name: 'Group 1');
//   when(mockHttpClient.put(Uri.parse('http://localhost:8000/groups/1/'),
//           headers: anyNamed('headers'), body: anyNamed('body')))
//       .thenAnswer((_) async => http.Response('', 200));
//   final result = await groupRepository.updateGroup(group);
//   expect(result, true);
//   verify(mockHttpClient.put(Uri.parse('http://localhost:8000/groups/1/'),
//       headers: anyNamed('headers'), body: group.toJson()));
// });

// test('createGroup returns a SimpleGroup', () async {
//   final group = SimpleGroup(id: '1', name: 'Group 1');
//   final expectedJson = {'id': '1', 'name': 'Group 1'};
//   when(mockHttpClient.post(Uri.parse('http://localhost:8000/groups/'),
//           headers: anyNamed('headers'), body: anyNamed('body')))
//       .thenAnswer((_) async =>
//           http.Response('{"id": "1", "name": "Group 1"}', 201));
//   final result = await groupRepository.createGroup(group);
//   expect(result, SimpleGroup.fromJson(expectedJson));
//   verify(mockHttpClient.post(Uri.parse('http://localhost:8000/groups/'),
//       headers: anyNamed('headers'), body: group.toJson()));
// });

// test('addMember returns true', () async {
//   final group = Group(id: '1', name: 'Group 1', members: []);
//   final user = SimpleUser(id: '1', name: 'User 1');
//   when(mock

// finish


// HttpClient.post(Uri.parse('http://localhost:8000/groups/membership/'),
// headers: anyNamed('headers'), body: anyNamed('body')))
// .thenAnswer((_) async => http.Response('', 201));
// final result = await groupRepository.addMember(group, user);
// expect(result, true);
// verify(mockHttpClient.post(Uri.parse('http://localhost:8000/groups/membership/'),
// headers: anyNamed('headers'),
// body: {'user_id': '1', 'group_id': '1'}));
// });

// test('deleteMember returns true', () async {
//   final group = Group(id: '1', name: 'Group 1', members: []);
//   final user = SimpleUser(id: '1', name: 'User 1');
//   when(mockHttpClient.delete(Uri.parse('http://localhost:8000/groups/membership/'),
//           headers: anyNamed('headers'), body: anyNamed('body')))
//       .thenAnswer((_) async => http.Response('', 204));
//   final result = await groupRepository.deleteMember(group, user);
//   expect(result, true);
//   verify(mockHttpClient.delete(Uri.parse('http://localhost:8000/groups/membership/'),
//       headers: anyNamed('headers'),
//       body: {'user_id': '1', 'group_id': '1'}));
// });

// test('getGroupList throws AppException when response status code is not 200', () async {
//   when(mockHttpClient.get(Uri.parse('http://localhost:8000/groups/'),
//           headers: anyNamed('headers')))
//       .thenAnswer((_) async =>
//           http.Response('{"error": "Not found"}', 404));
//   expect(() => groupRepository.getGroupList(),
//       throwsA(isInstanceOf<AppException>()));
//   verify(mockHttpClient.get(Uri.parse('http://localhost:8000/groups/'),
//       headers: anyNamed('headers')));
// });

// test('getGroup throws AppException when response status code is not 200', () async {
//   when(mockHttpClient.get(Uri.parse('http://localhost:8000/groups/1/'),
//           headers: anyNamed('headers')))
//       .thenAnswer((_) async =>
//           http.Response('{"error": "Not found"}', 404));
//   expect(() => groupRepository.getGroup('1'),
//       throwsA(isInstanceOf<AppException>()));
//   verify(mockHttpClient.get(Uri.parse('http://localhost:8000/groups/1/'),
//       headers: anyNamed('headers')));
// });

// test('deleteGroup throws AppException when response status code is not 204', () async {
//   when(mockHttpClient.delete(Uri.parse('http://localhost:8000/groups/1/'),
//           headers: anyNamed('headers')))
//       .thenAnswer((_) async => http.Response('{"error": "Forbidden"}', 403));
//   expect(() => groupRepository.deleteGroup('1'),
//       throwsA(isInstanceOf<AppException>()));
//   verify(mockHttpClient.delete(Uri.parse('http://localhost:8000/groups/1/'),
//       headers: anyNamed('headers')));
// });

// test('updateGroup throws AppException when response status code is not 200', () async {
//   final group = SimpleGroup(id: '1', name: 'Group 1');
//   when(mockHttpClient.put(Uri.parse('http://localhost:8000/groups/1/'),
//           headers: anyNamed('headers'), body: anyNamed('body')))
//       .thenAnswer((_) async => http.Response('{"error": "Forbidden"}', 403));
//   expect(() => groupRepository.updateGroup(group),
//       throwsA(isInstanceOf<AppException>()));
//   verify(mockHttpClient.put(Uri.parse('http://localhost:8000/groups/1/'),
//       headers: anyNamed('headers'), body: group.toJson()));
// });

// test('createGroup throws AppException when response status code is not 201', () async {
//   final group = SimpleGroup(id: '1', name: 'Group 1');
//   when(mockHttpClient.post(Uri.parse('http://localhost:8000/groups/'),
//           headers: anyNamed('headers'), body: anyNamed('body')))
//       .thenAnswer((_) async =>
//           http.Response('{"error": "Bad request"}', 400));
//   expect(() => groupRepository.createGroup(group),
//       throwsA(isInstanceOf<AppException>()));
//   verify(mockHttpClient.post(Uri.parse('http://localhost:8000/groups/'),
//       headers: anyNamed('headers'), body: group.toJson()));
// });

// test('deleteMember throws AppException when response status code is not 204', () async {
//   final group = Group(id: '1', name: 'Group 1', members: []);
//   final user = SimpleUser(id: '1', name: 'User 1');
//   when(mockHttpClient.delete(Uri.parse('http://localhost:8000/groups/membership/'),
//           headers: anyNamed('headers'), body: anyNamed('body')))
//       .thenAnswer((_) async => http.Response('{"

// finish


// error": "Forbidden"}', 403));
// expect(() => groupRepository.deleteMember(group, user),
// throwsA(isInstanceOf()));
// verify(mockHttpClient.delete(Uri.parse('http://localhost:8000/groups/membership/'),
// headers: anyNamed('headers'),
// body: {'user_id': '1', 'group_id': '1'}));
// });
// });
// }