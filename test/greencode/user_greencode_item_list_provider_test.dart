import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/greencode/class/greencode_item.dart';
import 'package:myecl/greencode/providers/user_greencode_item_list_provider.dart';
import 'package:myecl/greencode/repositories/greencode_item_repository.dart';

class MockGreenCodeItemRepository extends Mock
    implements GreenCodeItemRepository {}

final greencodeItems = [
  GreenCodeItem.empty().copyWith(
    id: '1',
    qrCodeContent: 'QRCodeContent 1',
    title: 'GreenCodeItem 1',
    content: 'GreenCodeItem 1 content',
  ),
  GreenCodeItem.empty().copyWith(
    id: '2',
    qrCodeContent: 'QRCodeContent 2',
    title: 'GreenCodeItem 2',
    content: 'GreenCodeItem 2 content',
  ),
  GreenCodeItem.empty().copyWith(
    id: '3',
    qrCodeContent: 'QRCodeContent 3',
    title: 'GreenCodeItem 3',
    content: 'GreenCodeItem 3 content',
  ),
];
void main() {
  group('GreenCodeItemListNotifier', () {
    late UserGreenCodeItemListNotifier greencodeItemListNotifier;

    setUp(() {
      greencodeItemListNotifier = UserGreenCodeItemListNotifier(
        greencodeItemRepository: MockGreenCodeItemRepository(),
      );
    });

    test('loadGreenCodeItemList', () async {
      when(
        () => greencodeItemListNotifier.greencodeItemRepository
            .getCurrentUserGreenCodeItems(),
      ).thenAnswer((_) async => greencodeItems);
      await greencodeItemListNotifier.loadCurrentUserGreenCodeItemList();
      expect(
        greencodeItemListNotifier.state.when(
          data: (greencodeItems) => greencodeItems,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        greencodeItems,
      );
    });

    test('addCurrentUserToGreenCodeItem', () async {
      final newGreenCodeItem = GreenCodeItem.empty().copyWith(
        id: '4',
        qrCodeContent: 'QRCodeContent 4',
        title: 'GreenCodeItem 4',
        content: 'GreenCodeItem 4 content',
      );
      when(
        () => greencodeItemListNotifier.greencodeItemRepository
            .addCurrentUserToGreenCodeItem(newGreenCodeItem.id),
      ).thenAnswer((_) async => true);
      greencodeItemListNotifier.state =
          AsyncValue.data(greencodeItems.sublist(0));
      await greencodeItemListNotifier
          .addCurrentUserToGreenCodeItem(newGreenCodeItem);

      expect(
        greencodeItemListNotifier.state.when(
          data: (greencodeItems) => greencodeItems,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        greencodeItems + [newGreenCodeItem],
      );
    });

    test('removeCurrentUserFromGreenCodeItem', () async {
      final deletedGreenCodeItem = greencodeItems[1];
      when(
        () => greencodeItemListNotifier.greencodeItemRepository
            .removeCurrentUserFromGreenCodeItem(deletedGreenCodeItem.id),
      ).thenAnswer((_) async => true);

      greencodeItemListNotifier.state =
          AsyncValue.data(greencodeItems.sublist(0));
      await greencodeItemListNotifier
          .removeCurrentUserFromGreenCodeItem(deletedGreenCodeItem);

      expect(
        greencodeItemListNotifier.state.when(
          data: (greencodeItems) => greencodeItems,
          loading: () => [],
          error: (error, stackTrace) => [],
        ),
        greencodeItems
            .where(
              (greenCodeItem) => greenCodeItem.id != deletedGreenCodeItem.id,
            )
            .toList(),
      );
    });
  });
}
