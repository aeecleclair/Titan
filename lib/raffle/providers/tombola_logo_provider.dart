import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/raffle/providers/tombola_logos_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class TombolaLogoProvider extends SingleNotifier<Image> {
  Openapi get repository => ref.watch(repositoryProvider);
  late final TombolaLogosNotifier tombolaLogosNotifier;

  @override
  AsyncValue<Image> build() {
    tombolaLogosNotifier = ref.watch(tombolaLogosProvider.notifier);
    return const AsyncValue.loading();
  }

  Future<Image> getLogo(String id) async {
    final response = await repository.tombolaRafflesRaffleIdLogoGet(
      raffleId: id,
    );
    final logo = response.bodyBytes.isEmpty
        ? Image.asset(getTitanLogo())
        : Image.memory(response.bodyBytes);
    tombolaLogosNotifier.setTData(id, AsyncData([logo]));
    state = AsyncValue.data(logo);
    return logo;
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    await repository.tombolaRafflesRaffleIdLogoPost(raffleId: id, image: bytes);
    final logo = Image.memory(bytes);
    tombolaLogosNotifier.setTData(id, AsyncData([logo]));
    state = AsyncValue.data(logo);
    return logo;
  }
}

final tombolaLogoProvider =
    NotifierProvider<TombolaLogoProvider, AsyncValue<Image>>(
      TombolaLogoProvider.new,
    );
