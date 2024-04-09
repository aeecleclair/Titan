import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class PhPdfsFirstPageNotifier extends MapNotifier<String, Uint8List> {
  PhPdfsFirstPageNotifier() : super();
}

final phPdfsFirstPageProvider = StateNotifierProvider<PhPdfsFirstPageNotifier,
    Map<String, AsyncValue<List<Uint8List>>?>>((ref) {
  final phPdfsFirstPageNotifier = PhPdfsFirstPageNotifier();
  return phPdfsFirstPageNotifier;
});
