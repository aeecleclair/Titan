import 'dart:async';
import 'dart:typed_data';
import 'package:myecl/tools/repository/pdf_repository.dart';
import 'package:pdfx/pdfx.dart';

class PhPdfRepository extends PdfRepository {
  @override
  // ignore: overridden_fields
  final ext = "ph/";

  Future<PdfView> getPhPdf(String id) async {
    final uint8List = await getPdf("", suffix: "$id/pdf");
    final pdfController =
        PdfController(document: PdfDocument.openData(uint8List));

    return PdfView(controller: pdfController);
  }

  Future<PdfView> updatePhPdf(Uint8List bytes, String id) async {
    final uint8List = await addPdf(bytes, "", suffix: "$id/pdf");
    final pdfController =
        PdfController(document: PdfDocument.openData(uint8List));

    return PdfView(controller: pdfController);
  }
}
