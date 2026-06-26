import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class AssociationPictureMapNotifier extends MapNotifier<String, Image> {}

final associationPictureMapProvider =
    NotifierProvider<
      AssociationPictureMapNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >(() => AssociationPictureMapNotifier());
