import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/repositories/ph_pdf_repository.dart';

class PhPdf extends AsyncNotifier<Uint8List> {
  PhPdf(this.phId);

  final String phId;

  @override
  Future<Uint8List> build() async {
    final PhPdfRepository phPdfRepository = ref.watch(phPdfRepositoryProvider);
    return await phPdfRepository.getPhPdf(phId);
  }

  Future<Uint8List> updatePhPdf(Uint8List bytes) async {
    final PhPdfRepository phPdfRepository = ref.watch(phPdfRepositoryProvider);
    return await phPdfRepository.updatePhPdf(bytes, phId);
  }
}

final phPdfProvider = AsyncNotifierProvider.family<PhPdf, Uint8List, String>(
  PhPdf.new,
);
