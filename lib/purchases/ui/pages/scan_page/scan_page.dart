import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/class/seller.dart';
import 'package:myecl/purchases/providers/product_list_provider.dart';
import 'package:myecl/purchases/providers/product_provider.dart';
import 'package:myecl/purchases/providers/scanner_provider.dart';
import 'package:myecl/purchases/providers/seller_list_provider.dart';
import 'package:myecl/purchases/providers/seller_provider.dart';
import 'package:myecl/purchases/providers/tag_provider.dart';
import 'package:myecl/purchases/router.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/purchases/ui/pages/scan_page/qr_code_scanner.dart';
import 'package:myecl/purchases/ui/pages/scan_page/radio_chip.dart';
import 'package:myecl/purchases/ui/purchases.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ScanPage extends HookConsumerWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellers = ref.watch(sellerListProvider);
    final sellersNotifier = ref.watch(sellerListProvider.notifier);
    final sellerNotifier = ref.watch(sellerProvider.notifier);
    final seller = ref.watch(sellerProvider);
    final products = ref.watch(productListProvider);
    final productsNotifier = ref.watch(productListProvider.notifier);
    final product = ref.watch(productProvider);
    final productNotifier = ref.watch(productProvider.notifier);
    final scannerNotifier = ref.watch(scannerProvider.notifier);
    final scanner = ref.watch(scannerProvider);
    final tagNotifier = ref.watch(tagProvider.notifier);
    final tag = ref.watch(tagProvider);

    return PurchasesTemplate(
      child: Refresher(
        onRefresh: () async {
          await sellersNotifier.loadSellers();
          if (seller != Seller.empty()) {
            await productsNotifier.loadProducts(seller.id);
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            AsyncChild(
              value: sellers,
              builder: (context, sellers) {
                return Column(
                  children: [
                    Row(
                      children: [
                        ...sellers.isEmpty
                            ? [const SizedBox()]
                            : sellers.map(
                                (eachSeller) => RadioChip(
                                  label: eachSeller.name,
                                  selected: eachSeller == seller,
                                  onTap: () async {
                                    sellerNotifier.setSeller(eachSeller);
                                    await productsNotifier
                                        .loadProducts(eachSeller.id);
                                  },
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    AsyncChild(
                      value: products,
                      builder: (context, products) {
                        return ExpansionTile(
                          title: const Text(PurchasesTextConstants.products),
                          children: products.map((eachProduct) {
                            return GestureDetector(
                              onTap: () {
                                productNotifier.setProduct(eachProduct);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(eachProduct.nameFR),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            TextField(
              onChanged: (value) async {
                tagNotifier.setTag(value);
              },
              controller: TextEditingController(text: tag),
              cursorColor: PurchasesColorConstants.textDark,
              decoration: const InputDecoration(
                isDense: true,
                suffixIcon: Icon(
                  Icons.search,
                  color: PurchasesColorConstants.textDark,
                  size: 30,
                ),
                label: Text(
                  PurchasesTextConstants.tag,
                  style: TextStyle(
                    color: PurchasesColorConstants.textDark,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.gradient1),
                ),
              ),
            ),
            product.id == ""
                ? const Text(PurchasesTextConstants.pleaseSelectProduct)
                : QrCodeScanner(
                    product: product,
                    onScan: (secret) async {
                      await scannerNotifier.scanTicket(product.id, secret);
                      scanner.when(
                        data: (data) {
                          scannerNotifier.setScanner(
                            data.copyWith(
                              secret: secret,
                            ),
                          );
                          QR.to(
                            PurchasesRouter.root +
                                PurchasesRouter.scan +
                                PurchasesRouter.confirmation,
                          );
                        },
                        error: (error, stack) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                            ),
                          );
                        },
                        loading: () {},
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
