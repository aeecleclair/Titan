import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class PhCoverRepository {
  final Openapi client;
  PhCoverRepository(this.client);

  Future<Uint8List> getPhPdfFirstPage(String id) async {
    final response = await client.phPaperIdCoverGet(paperId: id);
    return response.bodyBytes;
  }
}

final phCoverRepositoryProvider = Provider<PhCoverRepository>(
  (ref) => PhCoverRepository(ref.watch(repositoryProvider)),
);
