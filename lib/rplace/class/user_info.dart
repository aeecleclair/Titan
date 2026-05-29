import 'package:titan/tools/functions.dart';

class UserInfo {
  late final DateTime lastplaced;

  UserInfo({required this.lastplaced});

  UserInfo.fromJson(Map<String, dynamic> json) {
    lastplaced = processDateFromAPI(json['date']);
  }

  @override
  String toString() => 'UserInfo(lastplaced: $lastplaced)';
}
