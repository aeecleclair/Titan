import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PhPdfsNotifier extends MapNotifier<String, SfPdfViewer> {
  PhPdfsNotifier() : super();
}

final phPdfsProvider = StateNotifierProvider<PhPdfsNotifier,
    Map<String, AsyncValue<List<SfPdfViewer>>?>>((ref) {
  PhPdfsNotifier phPdfsNotifier = PhPdfsNotifier();
  return phPdfsNotifier;
});
