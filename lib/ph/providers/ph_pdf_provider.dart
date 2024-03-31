import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_provider.dart';
import 'package:myecl/ph/repositories/ph_pdf_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PhPdfNotifier extends SingleNotifier<SfPdfViewer> {
  final phPdfRepository = PhPdfRepository();
  final PhPdfsNotifier phPdfsNotifier;
  PhPdfNotifier({required String token, required this.phPdfsNotifier})
      : super(const AsyncValue.loading()) {
    phPdfRepository.setToken(token);
  }

  Future<SfPdfViewer> getPhPdf(String id) async {
    final image = await phPdfRepository.getPhPdf(id);
    phPdfsNotifier.setTData(id, AsyncData([image]));
    return image;
  }

  Future<SfPdfViewer> updatePhPdf(String id, Uint8List bytes) async {
    phPdfsNotifier.setTData(id, const AsyncLoading());
    final image = await phPdfRepository.addPhPdf(bytes, id);
    phPdfsNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final phPdfProvider =
    StateNotifierProvider<PhPdfNotifier, AsyncValue<SfPdfViewer>>((ref) {
  final token = ref.watch(tokenProvider);
  final phPdfsNotifier = ref.watch(phPdfsProvider.notifier);
  return PhPdfNotifier(token: token, phPdfsNotifier: phPdfsNotifier);
});
