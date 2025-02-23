import 'dart:ui';
import 'package:myecl/tools/functions.dart';
//import 'package:myecl/user/class/list_users.dart';

class Pixel {
  late final double x;
  late final double y;
  late final String color;
  //late final SimpleUser user;

  Pixel({
    required this.x,
    required this.y,
    required this.color,
    //required this.user,
  });

  Pixel.fromJson(Map<String, dynamic> json) {
    //user = SimpleUser.fromJson(json['user']);
    x = json['x'];
    y = json['y'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['user_id'] = user.id;
    data['x'] = x;
    data['y'] = y;
    data['color'] = color;
    return data;
  }

  @override
  String toString() => 'Score(offset: ($x, $y), color: $color)';
}
