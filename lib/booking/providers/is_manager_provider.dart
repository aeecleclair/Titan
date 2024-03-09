import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/user_manager_list_provider.dart';

final isManagerProvider = StateProvider<bool>((ref) {
  final managers = ref.watch(userManagerListProvider);
  final managersName = managers.when(
      data: (managers) => managers.map((e) => e.name).toList(),
      loading: () => List<String>.empty(),
      error: (error, stackTrace) => List<String>.empty());
  return managersName.isNotEmpty;
});
