import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/simple_users.dart';

class UserTicket extends SimpleUser {
  UserTicket({
    required super.name,
    required super.firstname,
    required super.nickname,
    required super.id,
    required super.accountType,
    required this.promo,
    required this.floor,
    required this.createdOn,
  });
  late final int? promo;
  late final String? floor;
  late final DateTime? createdOn;

  UserTicket.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    promo = json['promo'];
    floor = json['floor'];
    createdOn = processDateFromAPI(json['created_on']);
  }

  @override
  Map<String, dynamic> toJson() {
    final users = super.toJson();
    users['promo'] = promo;
    users['floor'] = floor;
    users['created_on'] = createdOn != null
        ? processDateToAPI(createdOn!)
        : null;
    return users;
  }

  UserTicket.empty() : super.empty() {
    promo = null;
    floor = null;
    createdOn = null;
  }

  @override
  String getName() {
    if (nickname == null) {
      return '$firstname $name';
    }
    return '$nickname ($firstname $name)';
  }

  @override
  String toString() {
    return "UserTicket {name: $name, firstname: $firstname, nickname: $nickname, id: $id, promo: $promo, floor: $floor, created_on: $createdOn}";
  }
}
