import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/class/pretendance.dart';

final pretendanceProvider =
    StateNotifierProvider<PretendanceNotifier, Pretendance>((ref) {
  return PretendanceNotifier();
});

class PretendanceNotifier extends StateNotifier<Pretendance> {
  PretendanceNotifier() : super(Pretendance.empty());

  void setId(Pretendance p) {
    state = p;
  }
}
