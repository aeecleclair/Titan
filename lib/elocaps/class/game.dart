
import 'package:myecl/elocaps/class/caps_mode.dart';

class Game{
  Game({required this.id, required this.timestamp,required this.mode});
  late final String id;
  late final DateTime timestamp;
  late final CapsMode mode;

}