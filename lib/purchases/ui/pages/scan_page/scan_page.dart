import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/class/seller.dart';
import 'package:titan/purchases/providers/product_list_provider.dart';
import 'package:titan/purchases/providers/generated_ticket_provider.dart';
import 'package:titan/purchases/providers/scanner_provider.dart';
import 'package:titan/purchases/providers/seller_list_provider.dart';
import 'package:titan/purchases/providers/seller_provider.dart';
import 'package:titan/purchases/tools/constants.dart';
import 'package:titan/purchases/ui/pages/scan_page/ticket_card.dart';
import 'package:titan/purchases/ui/pages/scan_page/scan_dialog.dart';
import 'package:titan/purchases/ui/purchases.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

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
    final ticketGeneratorNotifier = ref.watch(ticketGeneratorProvider.notifier);
    final scannerNotifier = ref.watch(scannerProvider.notifier);

    return PurchasesTemplate(
      child: Refresher(
        onRefresh: () async {
          await sellersNotifier.loadSellers();
          if (seller != Seller.empty()) {
            await productsNotifier.loadProducts(seller.id);
          }
          scannerNotifier.reset();
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
                            await tokenExpireWrapper(ref, () async {
                              sellerNotifier.setSeller(eachSeller);
                              await productsNotifier.loadProducts(
                                eachSeller.id,
                              );
                            });
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
                              final scannableProducts = products.where(
                                (product) =>
                                    product.ticketGenerators.isNotEmpty,
                              );
                              if (scannableProducts.isEmpty) {
                                return const Text(
                                  PurchasesTextConstants.noScannableProducts,
                                );
                              }
                              return Column(
                                children: scannableProducts
                                    .map((product) {
                                      return product.ticketGenerators.map((
                                        ticket,
                                      ) {
                                        return TicketCard(
                                          product: product,
                                          ticket: ticket,
                                          onClicked: () {
                                            ticketGeneratorNotifier
                                                .setTicketGenerator(ticket);
                                            showDialog<bool>(
                                              context: context,
                                              builder: (context) => ScanDialog(
                                                sellerId: seller.id,
                                                productId: product.id,
                                                ticket: ticket,
                                              ),
                                            );
                                          },
                                        );
                                      });
                                    })
                                    .fold([], (a, b) => a..addAll(b)),
                              );
                            },
                          ),
                  ],
                );
              },
            ),
            // TextField(
            //   onChanged: (value) async {
            //     tagNotifier.setTag(value);
            //   },
            //   cursorColor: PurchasesColorConstants.textDark,
            //   decoration: const InputDecoration(
            //     isDense: true,
            //     label: Text(
            //       PurchasesTextConstants.tag,
            //       style: TextStyle(
            //         color: PurchasesColorConstants.textDark,
            //       ),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: ColorConstants.gradient1),
            //     ),
            //   ),
            // ),
            // tag == ""
            //     ? const Text(
            //         PurchasesTextConstants.noTagGiven,
            //         style: TextStyle(color: Colors.red),
            //       )
            //     : const SizedBox(),
            // product.id == ""
            //     ? const Text(PurchasesTextConstants.pleaseSelectProduct)
            //     : Padding(
            //         padding: const EdgeInsets.all(30),
            //         child: SizedBox(
            //           height: 300,
            //           width: 300,
            //           child: QRCodeScannerScreen(
            //             product: product,
            //             onScan: (secret) async {
            //               await scannerNotifier.scanTicket(product.id, secret);
            //               scanner.when(
            //                 data: (data) {
            //                   scannerNotifier.setScanner(
            //                     data.copyWith(
            //                       secret: secret,
            //                     ),
            //                   );
            //                   QR.to(
            //                     PurchasesRouter.root +
            //                         PurchasesRouter.scan +
            //                         PurchasesRouter.confirmation,
            //                   );
            //                 },
            //                 error: (error, stack) {
            //                   ScaffoldMessenger.of(context).showSnackBar(
            //                     SnackBar(
            //                       content: Text(error.toString()),
            //                     ),
            //                   );
            //                 },
            //                 loading: () {},
            //               );
            //             },
            //           ),
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }
}
