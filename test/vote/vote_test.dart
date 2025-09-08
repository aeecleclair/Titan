import 'package:flutter_test/flutter_test.dart';
import 'package:titan/admin/class/account_type.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/vote/class/members.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/class/result.dart';
import 'package:titan/vote/class/section.dart';
import 'package:titan/vote/class/votes.dart';
import 'package:titan/vote/repositories/status_repository.dart';
import 'package:titan/vote/tools/functions.dart';

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
        accountType: AccountType(type: 'external'),
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
      Member newMember = member.copyWith(id: 'id2');
      expect(newMember.id, 'id2');
      newMember = member.copyWith(name: 'name2');
      expect(newMember.name, 'name2');
      newMember = member.copyWith(firstname: 'firstname2');
      expect(newMember.firstname, 'firstname2');
      newMember = member.copyWith(nickname: 'nickname2');
      expect(newMember.nickname, 'nickname2');
      newMember = member.copyWith(role: 'role2');
      expect(newMember.role, 'role2');
    });

    test('Should print a Member', () {
      final member = Member(
        id: 'id',
        accountType: AccountType(type: 'external'),
        name: 'name',
        firstname: 'firstname',
        nickname: 'nickname',
        role: 'role',
      );
      expect(
        member.toString(),
        'Member{id: id, name: name, firstname: firstname, nickname: nickname, role: role}',
      );
    });

    test('Should return a Member from a SimpleUser', () {
      final member = Member.fromSimpleUser(
        SimpleUser(
          id: 'id',
          accountType: AccountType(type: 'external'),
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
          "account_type": "external",
        },
        "role": "role",
      });
      expect(member, isA<Member>());
      expect(member.id, 'id');
      expect(member.name, 'Name');
      expect(member.firstname, 'Firstname');
      expect(member.nickname, 'Nickname');
      expect(member.role, 'Role');
      expect(member.accountType, AccountType(type: 'external'));
    });

    test('Should return a correct json', () {
      final member = Member(
        id: 'id',
        accountType: AccountType(type: 'external'),
        name: 'name',
        firstname: 'firstname',
        nickname: 'nickname',
        role: 'role',
      );
      expect(member.toJson(), {"user_id": "id", "role": "role"});
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
      Section newSection = section.copyWith(id: 'id2');
      expect(newSection.id, 'id2');
      newSection = section.copyWith(name: 'name2');
      expect(newSection.name, 'name2');
      newSection = section.copyWith(description: 'description2');
      expect(newSection.description, 'description2');
    });

    test('Should print a Section', () {
      final section = Section(
        id: 'id',
        name: 'name',
        description: 'description',
      );
      expect(
        section.toString(),
        'Section{id: id, name: name, description: description}',
      );
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

  group('Testing Contender class', () {
    test('Should return a Contender', () {
      final contender = Contender.empty();
      expect(contender, isA<Contender>());
      expect(contender.id, '');
      expect(contender.name, '');
      expect(contender.description, '');
      expect(contender.members, []);
      expect(contender.listType, ListType.serious);
      expect(contender.section, isA<Section>());
      expect(contender.program, '');
    });

    test('Should return a Contender', () {
      final contender = Contender(
        id: 'id',
        name: 'name',
        description: 'description',
        members: [],
        listType: ListType.fake,
        section: Section.empty(),
        program: 'program',
      );
      expect(contender, isA<Contender>());
      expect(contender.id, 'id');
      expect(contender.name, 'name');
      expect(contender.description, 'description');
      expect(contender.members, []);
      expect(contender.listType, ListType.fake);
      expect(contender.section, isA<Section>());
      expect(contender.program, 'program');
    });

    test('Should update with new values', () {
      final contender = Contender.empty();
      Contender newContender = contender.copyWith(id: 'id2');
      expect(newContender.id, 'id2');
      newContender = contender.copyWith(name: 'name2');
      expect(newContender.name, 'name2');
      newContender = contender.copyWith(description: 'description2');
      expect(newContender.description, 'description2');
      newContender = contender.copyWith(members: []);
      expect(newContender.members, []);
      newContender = contender.copyWith(listType: ListType.fake);
      expect(newContender.listType, ListType.fake);
      newContender = contender.copyWith(section: Section.empty());
      expect(newContender.section, isA<Section>());
      newContender = contender.copyWith(program: 'program2');
      expect(newContender.program, 'program2');
    });

    test('Should print a Contender', () {
      final contender = Contender(
        id: 'id',
        name: 'name',
        description: 'description',
        members: [],
        listType: ListType.fake,
        section: Section.empty(),
        program: 'program',
      );
      expect(
        contender.toString(),
        'Contender{id: id, name: name, description: description, listType: ListType.fake, members: [], section: Section{id: , name: , description: }, program: program}',
      );
    });

    test('Should parse a Contender', () {
      final contender = Contender.fromJson({
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
      expect(contender, isA<Contender>());
      expect(contender.id, 'id');
      expect(contender.name, 'name');
      expect(contender.description, 'description');
      expect(contender.members, []);
      expect(contender.listType, ListType.fake);
      expect(contender.section, isA<Section>());
      expect(contender.program, 'program');
    });

    test('Should return a correct json', () {
      final contender = Contender(
        id: 'id',
        name: 'name',
        description: 'description',
        members: [],
        listType: ListType.fake,
        section: Section.empty(),
        program: 'program',
      );
      expect(contender.toJson(), {
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
      final result = Result(id: 'id', count: 1);
      expect(result, isA<Result>());
      expect(result.id, 'id');
      expect(result.count, 1);
    });

    test('Should print a Result', () {
      final result = Result(id: 'id', count: 1);
      expect(result.toString(), 'Result{id: id, count: 1}');
    });

    test('Should parse a Result', () {
      final result = Result.fromJson({"list_id": "id", "count": 1});
      expect(result, isA<Result>());
      expect(result.id, 'id');
      expect(result.count, 1);
    });

    test('Should update with new value', () {
      final result = Result.empty();
      Result newResult = result.copyWith(id: 'id2');
      expect(newResult.id, 'id2');
      newResult = result.copyWith(count: 2);
      expect(newResult.count, 2);
    });

    test('Should return a correct json', () {
      final result = Result(id: 'id', count: 1);
      expect(result.toJson(), {"list_id": "id", "count": 1});
    });
  });

  group('Testing Votes class', () {
    test('Should return a Votes', () {
      final votes = Votes.empty();
      expect(votes, isA<Votes>());
      expect(votes.id, '');
    });

    test('Should return a Votes', () {
      final votes = Votes(id: 'id');
      expect(votes, isA<Votes>());
      expect(votes.id, 'id');
    });

    test('Should print a Votes', () {
      final votes = Votes(id: 'id');
      expect(votes.toString(), 'Votes{id: id}');
    });

    test('Should return a correct json', () {
      final votes = Votes(id: 'id');
      expect(votes.toJson(), {"list_id": "id"});
    });
  });

  group('Testing functions', () {
    test('Should return a ListType', () {
      expect(stringToListType('Pipo'), ListType.fake);
      expect(stringToListType('Serio'), ListType.serious);
      expect(stringToListType('Blank'), ListType.blank);
      expect(stringToListType(''), ListType.blank);
    });

    test('Should return a Status', () {
      expect(stringToStatus('waiting'), Status.waiting);
      expect(stringToStatus('open'), Status.open);
      expect(stringToStatus('closed'), Status.closed);
      expect(stringToStatus('counting'), Status.counting);
      expect(stringToStatus('published'), Status.published);
      expect(stringToStatus(''), Status.waiting);
    });

    test('Should return a String', () {
      expect(statusToString(Status.waiting), 'Waiting');
      expect(statusToString(Status.open), 'Open');
      expect(statusToString(Status.closed), 'Closed');
      expect(statusToString(Status.counting), 'Counting');
      expect(statusToString(Status.published), 'Published');
    });
  });
}
