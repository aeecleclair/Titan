import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/providers/list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

void main() {
  group('ListNotifier', () {
    late ProviderContainer container;
    late ListNotifier notifier;
    final list = ListReturn.fromJson({}).copyWith(id: '123', name: 'John Doe');

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(listProvider.notifier);
    });

    test('setId should update the state', () {
      notifier.setId(list);

      expect(container.read(listProvider).id, equals('123'));
      expect(container.read(listProvider).name, equals('John Doe'));
    });

    test('resetId should reset the state', () {
      notifier.setId(list);
      notifier.setId(ListReturn.fromJson({}));

      expect(container.read(listProvider).id, equals(''));
      expect(container.read(listProvider).name, equals(''));
    });
  });
}
