import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/providers/user_manager_list_provider.dart';

final isManagerProvider = StateProvider<bool>((ref) {
  final managers = ref.watch(userManagerListProvider);
  final managersName = managers.when(
    data: (managers) => managers.map((e) => e.name).toList(),
    loading: () => [],
    error: (error, stackTrace) => [],
  );
  return managersName.isNotEmpty;
});
