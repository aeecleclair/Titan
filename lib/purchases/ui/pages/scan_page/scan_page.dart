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
import 'package:myecl/purchases/ui/purchases.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
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

    ExpansionTileController controller = ExpansionTileController();

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
            const SizedBox(height: 20),
            AsyncChild(
              value: sellers,
              builder: (context, sellers) {
                return Column(
                  children: [
                    HorizontalListView.builder(
                      height: 40,
                      items: sellers,
                      itemBuilder: (context, eachSeller, i) {
                        final selected = eachSeller == seller;
                        return ItemChip(
                          selected: selected,
                          onTap: () async {
                            sellerNotifier.setSeller(eachSeller);
                            await productsNotifier.loadProducts(eachSeller.id);
                            controller.expand();
                          },
                          child: Text(
                            eachSeller.name,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    seller.id == ""
                        ? const Text(PurchasesTextConstants.pleaseSelectSeller)
                        : AsyncChild(
                            value: products,
                            builder: (context, products) {
                              return ExpansionTile(
                                title: Text(
                                  "${PurchasesTextConstants.products}: ${product.id == "" ? PurchasesTextConstants.pleaseSelectProduct : product.nameFR}",
                                ),
                                controller: controller,
                                children: products.map((eachProduct) {
                                  return GestureDetector(
                                    onTap: () {
                                      productNotifier.setProduct(eachProduct);
                                      controller.collapse();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Text(eachProduct.nameFR),
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
              cursorColor: PurchasesColorConstants.textDark,
              decoration: const InputDecoration(
                isDense: true,
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
            tag == ""
                ? const Text(
                    PurchasesTextConstants.noTagGiven,
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            product.id == ""
                ? const Text(PurchasesTextConstants.pleaseSelectProduct)
                : Padding(
                    padding: const EdgeInsets.all(30),
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: QRCodeScannerScreen(
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
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
