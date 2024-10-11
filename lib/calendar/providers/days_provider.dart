import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/calendar/providers/number_day_provider.dart';
import 'package:myecl/tools/functions.dart';

final daysProvider = Provider<List<DateTime>>((ref) {
  final numberDay = ref.watch(numberDayProvider);
  final now = DateTime.now();
  return List<DateTime>.generate(
    numberDay,
    (index) => normalizedDate(now.add(Duration(days: index))),
  );
});
