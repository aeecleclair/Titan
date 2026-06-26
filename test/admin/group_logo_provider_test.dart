import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/admin/repositories/association_logo_repository.dart';

class MockAssociationLogoRepository extends Mock
    implements AssociationLogoRepository {}

void main() {
  group('AssociationLogoNotifier', () {
    // test('getLogo returns logo image', () async {
    //   final repository = MockAssociationLogoRepository();
    //   when(
    //     () => repository.getLogo('123', suffix: '/logo'),
    //   ).thenAnswer((_) async => Uint8List(1));
    //   final notifier = AssociationLogoNotifier();

    //   final image = await notifier.getLogo('123');

    //   expect(image, isA<Image>());
    //   expect(image.image, isA<MemoryImage>());
    // });

    // // Issue with flavor
    // test('getLogo returns logo image', () async {
    // //   final repository = MockAssociationLogoRepository();
    // //   when(
    //     () => repository.getLogo('123', suffix: '/logo'),
    // //   ).thenAnswer((_) async => Uint8List(0));
    // //   final notifier = AssociationLogoNotifier();

    //   final image = await notifier.getLogo('123');

    //   expect(image, isA<Image>());
    //   expect(image.image, isA<AssetImage>());
    // });

    // test('updateLogo returns logo image', () async {
    //   final repository = MockAssociationLogoRepository();
    //   final Uint8List bytes = Uint8List(1);
    //   when(
    //     () => repository.addLogo(bytes, '123', suffix: '/logo'),
    //   ).thenAnswer((_) async => Uint8List(1));
    //   final notifier = AssociationLogoNotifier();

    //   final image = await notifier.updateLogo('123', bytes);

    //   expect(image, isA<Image>());
    // });
  });
}
