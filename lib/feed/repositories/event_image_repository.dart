import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class EventImageRepository {
  final Openapi client;
  EventImageRepository(this.client);

  Future<Image> getEventImage(String id) async {
    final response = await client.calendarEventsEventIdImageGet(eventId: id);
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> addEventImage(Uint8List bytes, String id) async {
    await client.calendarEventsEventIdImagePost(eventId: id, image: bytes);
    return Image.memory(bytes);
  }
}

final eventImageRepositoryProvider = Provider<EventImageRepository>(
  (ref) => EventImageRepository(ref.watch(repositoryProvider)),
);
