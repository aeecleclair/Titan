import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_provider.dart';
import 'package:myecl/ph/repositories/ph_pdf_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class PhPdfNotifier extends SingleNotifier<Uint8List> {
  final phPdfRepository = PhPdfRepository();
  final PhPdfsNotifier phPdfsNotifier;
  PhPdfNotifier({required String token, required this.phPdfsNotifier})
      : super(const AsyncValue.loading()) {
    phPdfRepository.setToken(token);
  }

  Future<Uint8List> loadPhPdf(String id) async {
    final pdf = await phPdfRepository.getPhPdf(id);
    phPdfsNotifier.setTData(id, AsyncData([pdf]));
    return pdf;
  }

  Future<Uint8List> updatePhPdf(String id, Uint8List bytes) async {
    phPdfsNotifier.setTData(id, const AsyncLoading());
    final pdf = await phPdfRepository.updatePhPdf(bytes, id);
    phPdfsNotifier.setTData(id, AsyncData([pdf]));
    return pdf;
  }
}

final phPdfProvider =
    StateNotifierProvider<PhPdfNotifier, AsyncValue<Uint8List>>((ref) {
  final token = ref.watch(tokenProvider);
  final phPdfsNotifier = ref.watch(phPdfsProvider.notifier);
  return PhPdfNotifier(token: token, phPdfsNotifier: phPdfsNotifier);
});
