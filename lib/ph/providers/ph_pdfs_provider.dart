import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class PhPdfsNotifier extends MapNotifier<String, Uint8List> {
  PhPdfsNotifier() : super();
}

final phPdfsProvider = StateNotifierProvider<PhPdfsNotifier,
    Map<String, AsyncValue<List<Uint8List>>?>>((ref) {
  final phPdfsNotifier = PhPdfsNotifier();
  return phPdfsNotifier;
});
