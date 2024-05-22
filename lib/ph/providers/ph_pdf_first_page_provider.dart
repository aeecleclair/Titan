import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_first_page_provider.dart';
import 'package:myecl/ph/repositories/ph_pdf_first_page_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class PhPdfFirstPageNotifier extends SingleNotifier<Uint8List> {
  final phPdfFirstPageRepository = PhPdfFirstPageRepository();
  final PhPdfsFirstPageNotifier phPdfsFirstPageNotifier;
  PhPdfFirstPageNotifier({
    required String token,
    required this.phPdfsFirstPageNotifier,
  }) : super(const AsyncValue.loading()) {
    phPdfFirstPageRepository.setToken(token);
  }

  Future<Uint8List> loadPhPdfFirstPage(String id) async {
    final image = await phPdfFirstPageRepository.getPhPdfFirstPage(id);
    phPdfsFirstPageNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final phPdfFirstPageProvider =
    StateNotifierProvider<PhPdfFirstPageNotifier, AsyncValue<Uint8List>>((ref) {
  final token = ref.watch(tokenProvider);
  final phPdfsFirstPageNotifier = ref.watch(phPdfsFirstPageProvider.notifier);
  return PhPdfFirstPageNotifier(
    token: token,
    phPdfsFirstPageNotifier: phPdfsFirstPageNotifier,
  );
});
