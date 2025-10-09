import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/repositories/ph_pdf_repository.dart';

class PhPdf extends FamilyAsyncNotifier<Uint8List, String> {
  @override
  Future<Uint8List> build(String arg) async {
    final PhPdfRepository phPdfRepository = ref.watch(phPdfRepositoryProvider);
    return await phPdfRepository.getPhPdf(arg);
  }

  Future<Uint8List> updatePhPdf(Uint8List bytes) async {
    final PhPdfRepository phPdfRepository = ref.watch(phPdfRepositoryProvider);
    return await phPdfRepository.updatePhPdf(bytes, arg);
  }
}

final phPdfProvider = AsyncNotifierProvider.family<PhPdf, Uint8List, String>(
  PhPdf.new,
);
