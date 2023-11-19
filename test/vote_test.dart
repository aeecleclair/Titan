import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/vote/class/members.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/class/result.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/class/votes.dart';

void main() {
  group('Testing Member class', () {
    test('Should return a Member', () {
      final member = Member.empty();
      expect(member, isA<Member>());
      expect(member.id, '');
      expect(member.name, '');
      expect(member.firstname, '');
      expect(member.nickname, '');
      expect(member.role, '');
    });

    test('Should return a Member', () {
      final member = Member(
        id: 'id',
        name: 'name',
        firstname: 'firstname',
        nickname: 'nickname',
        role: 'role',
      );
      expect(member, isA<Member>());
      expect(member.id, 'id');
      expect(member.name, 'name');
      expect(member.firstname, 'firstname');
      expect(member.nickname, 'nickname');
      expect(member.role, 'role');
    });

    test('Should update with new values', () {
      final member = Member.empty();
      Member newMember = member.copyWith(
        id: 'id2',
      );
      expect(newMember.id, 'id2');
      newMember = member.copyWith(
        name: 'name2',
      );
      expect(newMember.name, 'name2');
      newMember = member.copyWith(
        firstname: 'firstname2',
      );
      expect(newMember.firstname, 'firstname2');
      newMember = member.copyWith(
        nickname: 'nickname2',
      );
      expect(newMember.nickname, 'nickname2');
      newMember = member.copyWith(
        role: 'role2',
      );
      expect(newMember.role, 'role2');
    });

    test('Should print a Member', () {
      final member = Member(
        id: 'id',
        name: 'name',
        firstname: 'firstname',
        nickname: 'nickname',
        role: 'role',
      );
      expect(member.toString(),
          'Member{id: id, name: name, firstname: firstname, nickname: nickname, role: role}');
    });

    test('Should return a Member from a SimpleUser', () {
      final member = Member.fromSimpleUser(
        SimpleUser(
          id: 'id',
          name: 'name',
          firstname: 'firstname',
          nickname: 'nickname',
        ),
        'role',
      );
      expect(member, isA<Member>());
      expect(member.id, 'id');
      expect(member.name, 'name');
      expect(member.firstname, 'firstname');
      expect(member.nickname, 'nickname');
      expect(member.role, 'role');
    });

    test('Should parse a Member', () {
      final member = Member.fromJson({
        "user": {
          "id": "id",
          "name": "name",
          "firstname": "firstname",
          "nickname": "nickname",
        },
        "role": "role",
      });
      expect(member, isA<Member>());
      expect(member.id, 'id');
      expect(member.name, 'Name');
      expect(member.firstname, 'Firstname');
      expect(member.nickname, 'Nickname');
      expect(member.role, 'Role');
    });

    test('Should return a correct json', () {
      final member = Member(
        id: 'id',
        name: 'name',
        firstname: 'firstname',
        nickname: 'nickname',
        role: 'role',
      );
      expect(member.toJson(), {
        "user_id": "id",
        "role": "role",
      });
    });
  });

  group('Testing Section class', () {
    test('Should return a Section', () {
      final section = Section.empty();
      expect(section, isA<Section>());
      expect(section.id, '');
      expect(section.name, '');
      expect(section.description, '');
    });

    test('Should return a Section', () {
      final section = Section(
        id: 'id',
        name: 'name',
        description: 'description',
      );
      expect(section, isA<Section>());
      expect(section.id, 'id');
      expect(section.name, 'name');
      expect(section.description, 'description');
    });

    test('Should update with new values', () {
      final section = Section.empty();
      Section newSection = section.copyWith(
        id: 'id2',
      );
      expect(newSection.id, 'id2');
      newSection = section.copyWith(
        name: 'name2',
      );
      expect(newSection.name, 'name2');
      newSection = section.copyWith(
        description: 'description2',
      );
      expect(newSection.description, 'description2');
    });

    test('Should print a Section', () {
      final section = Section(
        id: 'id',
        name: 'name',
        description: 'description',
      );
      expect(section.toString(),
          'Section{id: id, name: name, description: description}');
    });

    test('Should parse a Section', () {
      final section = Section.fromJson({
        "id": "id",
        "name": "name",
        "description": "description",
      });
      expect(section, isA<Section>());
      expect(section.id, 'id');
      expect(section.name, 'name');
      expect(section.description, 'description');
    });

    test('Should return a correct json', () {
      final section = Section(
        id: 'id',
        name: 'name',
        description: 'description',
      );
      expect(section.toJson(), {
        "id": "id",
        "name": "name",
        "description": "description",
      });
    });
  });

  group('Testing Pretendance class', () {
    test('Should return a Pretendance', () {
      final pretendance = Pretendance.empty();
      expect(pretendance, isA<Pretendance>());
      expect(pretendance.id, '');
      expect(pretendance.name, '');
      expect(pretendance.description, '');
      expect(pretendance.members, []);
      expect(pretendance.listType, ListType.serio);
      expect(pretendance.section, isA<Section>());
      expect(pretendance.program, '');
    });

    test('Should return a Pretendance', () {
      final pretendance = Pretendance(
        id: 'id',
        name: 'name',
        description: 'description',
        members: [],
        listType: ListType.pipo,
        section: Section.empty(),
        program: 'program',
      );
      expect(pretendance, isA<Pretendance>());
      expect(pretendance.id, 'id');
      expect(pretendance.name, 'name');
      expect(pretendance.description, 'description');
      expect(pretendance.members, []);
      expect(pretendance.listType, ListType.pipo);
      expect(pretendance.section, isA<Section>());
      expect(pretendance.program, 'program');
    });

    test('Should update with new values', () {
      final pretendance = Pretendance.empty();
      Pretendance newPretendance = pretendance.copyWith(
        id: 'id2',
      );
      expect(newPretendance.id, 'id2');
      newPretendance = pretendance.copyWith(
        name: 'name2',
      );
      expect(newPretendance.name, 'name2');
      newPretendance = pretendance.copyWith(
        description: 'description2',
      );
      expect(newPretendance.description, 'description2');
      newPretendance = pretendance.copyWith(
        members: [],
      );
      expect(newPretendance.members, []);
      newPretendance = pretendance.copyWith(
        listType: ListType.pipo,
      );
      expect(newPretendance.listType, ListType.pipo);
      newPretendance = pretendance.copyWith(
        section: Section.empty(),
      );
      expect(newPretendance.section, isA<Section>());
      newPretendance = pretendance.copyWith(
        program: 'program2',
      );
      expect(newPretendance.program, 'program2');
    });

    test('Should print a Pretendance', () {
      final pretendance = Pretendance(
        id: 'id',
        name: 'name',
        description: 'description',
        members: [],
        listType: ListType.pipo,
        section: Section.empty(),
        program: 'program',
      );
      expect(pretendance.toString(),
          'Pretendance{id: id, name: name, description: description, listType: ListType.pipo, members: [], section: Section{id: , name: , description: }, program: program}');
    });

    test('Should parse a Pretendance', () {
      final pretendance = Pretendance.fromJson({
        "id": "id",
        "name": "name",
        "description": "description",
        "members": [],
        "type": "Pipo",
        "section": {
          "id": "id",
          "name": "name",
          "description": "description",
          "members": [],
        },
        "program": "program",
      });
      expect(pretendance, isA<Pretendance>());
      expect(pretendance.id, 'id');
      expect(pretendance.name, 'name');
      expect(pretendance.description, 'description');
      expect(pretendance.members, []);
      expect(pretendance.listType, ListType.pipo);
      expect(pretendance.section, isA<Section>());
      expect(pretendance.program, 'program');
    });

    test('Should return a correct json', () {
      final pretendance = Pretendance(
        id: 'id',
        name: 'name',
        description: 'description',
        members: [],
        listType: ListType.pipo,
        section: Section.empty(),
        program: 'program',
      );
      expect(pretendance.toJson(), {
        "id": "id",
        "name": "name",
        "description": "description",
        "members": [],
        "type": "Pipo",
        "section_id": "",
        "program": "program",
      });
    });
  });

  group('Testing Result class', () {
    test('Should return a Result', () {
      final result = Result.empty();
      expect(result, isA<Result>());
      expect(result.id, '');
      expect(result.count, 0);
    });

    test('Should return a Result', () {
      final result = Result(
        id: 'id',
        count: 1,
      );
      expect(result, isA<Result>());
      expect(result.id, 'id');
      expect(result.count, 1);
    });

    test('Should print a Result', () {
      final result = Result(
        id: 'id',
        count: 1,
      );
      expect(result.toString(), 'Result{id: id, count: 1}');
    });

    test('Should parse a Result', () {
      final result = Result.fromJson({
        "list_id": "id",
        "count": 1,
      });
      expect(result, isA<Result>());
      expect(result.id, 'id');
      expect(result.count, 1);
    });

    test('Should return a correct json', () {
      final result = Result(
        id: 'id',
        count: 1,
      );
      expect(result.toJson(), {
        "list_id": "id",
        "count": 1,
      });
    });
  });

  group('Testing Votes class', () {
    test('Should return a Votes', () {
      final votes = Votes.empty();
      expect(votes, isA<Votes>());
      expect(votes.id, '');
    });

    test('Should return a Votes', () {
      final votes = Votes(
        id: 'id',
      );
      expect(votes, isA<Votes>());
      expect(votes.id, 'id');
    });

    test('Should print a Votes', () {
      final votes = Votes(
        id: 'id',
      );
      expect(votes.toString(), 'Votes{id: id}');
    });

    test('Should return a correct json', () {
      final votes = Votes(
        id: 'id',
      );
      expect(votes.toJson(), {
        "list_id": "id",
      });
    });
  });
}
