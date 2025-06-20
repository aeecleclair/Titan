import 'dart:async';
import 'dart:typed_data';
import 'package:myecl/tools/repository/pdf_repository.dart';

class PhPdfRepository extends PdfRepository {
  @override
  // ignore: overridden_fields
  final ext = "ph/";

  PhPdfRepository(super.ref);

  Future<Uint8List> getPhPdf(String id) async {
    final uint8List = await getPdf("", suffix: "$id/pdf");
    return uint8List;
  }

  Future<Uint8List> updatePhPdf(Uint8List bytes, String id) async {
    final uint8List = await addPdf(bytes, "", suffix: "$id/pdf");
    return uint8List;
  }
}
