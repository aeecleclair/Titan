import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

class PixelInfo {
  late final SimpleUser user;
  late final DateTime date;

  PixelInfo({
    required this.user,
    required this.date,
  });

  PixelInfo.fromJson(Map<String, dynamic> json) {
    user = SimpleUser.fromJson(json['user']);
    date = processDateFromAPI(json['date']);
  }

  static PixelInfo empty() {
    return PixelInfo(
      user: SimpleUser.empty(),
      date: DateTime.now(),
    );
  }

  @override
  String toString() => 'PixelInfo(user: ($user), date: $date)';
}
