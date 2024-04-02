import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:pdfx/pdfx.dart';

class PhPdfsNotifier extends MapNotifier<String, PdfView> {
  PhPdfsNotifier() : super();
}

final phPdfsProvider = StateNotifierProvider<PhPdfsNotifier,
    Map<String, AsyncValue<List<PdfView>>?>>((ref) {
  PhPdfsNotifier phPdfsNotifier = PhPdfsNotifier();
  return phPdfsNotifier;
});
