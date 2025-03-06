import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/purchases/providers/product_list_provider.dart';
import 'package:myecl/purchases/providers/generated_ticket_provider.dart';
import 'package:myecl/purchases/providers/scanner_provider.dart';
import 'package:myecl/purchases/providers/seller_list_provider.dart';
import 'package:myecl/purchases/providers/seller_provider.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/purchases/ui/pages/scan_page/ticket_card.dart';
import 'package:myecl/purchases/ui/pages/scan_page/scan_dialog.dart';
import 'package:myecl/purchases/ui/purchases.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

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
          if (seller.id != EmptyModels.empty<SellerComplete>().id) {
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
                            sellerNotifier.setSeller(eachSeller);
                            await productsNotifier.loadProducts(eachSeller.id);
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
                                (product) => (product.tickets ?? []).isNotEmpty,
                              );
                              if (scannableProducts.isEmpty) {
                                return const Text(
                                  PurchasesTextConstants.noScannableProducts,
                                );
                              }
                              return Column(
                                children: scannableProducts.map((product) {
                                  return (product.tickets ?? []).map((ticket) {
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
                                }).fold([], (a, b) => a..addAll(b)),
                              );
                            },
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
