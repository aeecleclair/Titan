import 'dart:async';
import 'dart:typed_data';
import 'package:myecl/tools/repository/pdf_repository.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PhPdfRepository extends PdfRepository {
  @override
  // ignore: overridden_fields
  final ext = "ph/";

  Future<SfPdfViewer> getPhPdf(String id) async {
    final uint8List = await getPdf("", suffix: "$id/pdf");
    if (uint8List.isEmpty) {
      return SfPdfViewer.asset('assets/my_document.pdf',
          pageLayoutMode: PdfPageLayoutMode.single);
    }
    return SfPdfViewer.memory(uint8List);
  }

  Future<SfPdfViewer> addPhPdf(Uint8List bytes, String id) async {
    final uint8List = await addPdf(bytes, "", suffix: "$id/pdf");
    return SfPdfViewer.memory(uint8List);
  }
}
