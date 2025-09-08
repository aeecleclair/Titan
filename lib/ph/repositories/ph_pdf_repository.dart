import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/pdf_repository.dart';

class PhPdfRepository extends PdfRepository {
  @override
  // ignore: overridden_fields
  final ext = "ph/";

  Future<Uint8List> getPhPdf(String id) async {
    final uint8List = await getPdf("", suffix: "$id/pdf");
    return uint8List;
  }

  Future<Uint8List> updatePhPdf(Uint8List bytes, String id) async {
    final uint8List = await addPdf(bytes, "", suffix: "$id/pdf");
    return uint8List;
  }
}

final phPdfRepositoryProvider = Provider<PhPdfRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return PhPdfRepository()..setToken(token);
});
