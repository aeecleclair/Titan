import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/room_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

void main() {
  group('RoomNotifier', () {
    late ProviderContainer container;
    late RoomNotifier notifier;
    final room = RoomComplete(
      id: '1',
      name: 'Test Room',
      managerId: '123',
    );

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(roomProvider.notifier);
    });

    test('setRoom should update state', () {
      notifier.setRoom(room);

      expect(container.read(roomProvider).id, equals('1'));
      expect(container.read(roomProvider).name, equals('Test Room'));
      expect(container.read(roomProvider).managerId, equals('123'));
    });

    test('resetRoom should reset state', () {
      notifier.setRoom(room);
      notifier.setRoom(RoomComplete.fromJson({}));

      expect(container.read(roomProvider).id, equals(''));
      expect(container.read(roomProvider).name, equals(''));
      expect(container.read(roomProvider).managerId, equals(''));
    });
  });
}
