import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/service/class/room.dart';
import 'package:titan/booking/providers/room_provider.dart';

void main() {
  group('RoomNotifier', () {
    test('setRoom should update state', () {
      final container = ProviderContainer();
      final notifier = container.read(roomProvider.notifier);

      final room = Room(id: '1', name: 'Test Room', managerId: '123');

      notifier.setRoom(room);

      expect(container.read(roomProvider).id, equals('1'));
      expect(container.read(roomProvider).name, equals('Test Room'));
      expect(container.read(roomProvider).managerId, equals('123'));
    });
  });
}
