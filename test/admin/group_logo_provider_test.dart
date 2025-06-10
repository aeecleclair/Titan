import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/admin/providers/group_logo_provider.dart';
import 'package:titan/admin/repositories/group_logo_repository.dart';

class MockGroupLogoRepository extends Mock implements GroupLogoRepository {}

void main() {
  group('GroupLogoNotifier', () {
    test('getLogo returns logo image', () async {
      final repository = MockGroupLogoRepository();
      when(
        () => repository.getLogo('123', suffix: '/logo'),
      ).thenAnswer((_) async => Uint8List(1));
      final notifier = GroupLogoNotifier(groupLogoRepository: repository);

      final image = await notifier.getLogo('123');

      expect(image, isA<Image>());
      expect(image.image, isA<MemoryImage>());
    });

    test('getLogo returns logo image', () async {
      final repository = MockGroupLogoRepository();
      when(
        () => repository.getLogo('123', suffix: '/logo'),
      ).thenAnswer((_) async => Uint8List(0));
      final notifier = GroupLogoNotifier(groupLogoRepository: repository);

      final image = await notifier.getLogo('123');

      expect(image, isA<Image>());
      expect(image.image, isA<AssetImage>());
    });

    test('updateLogo returns logo image', () async {
      final repository = MockGroupLogoRepository();
      final Uint8List bytes = Uint8List(1);
      when(
        () => repository.addLogo(bytes, '123', suffix: '/logo'),
      ).thenAnswer((_) async => Uint8List(1));
      final notifier = GroupLogoNotifier(groupLogoRepository: repository);

      final image = await notifier.updateLogo('123', bytes);

      expect(image, isA<Image>());
    });
  });
}
