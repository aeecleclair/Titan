import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/purchases/class/product.dart';
import 'package:titan/purchases/class/ticket_generator.dart';
import 'package:titan/purchases/providers/product_id_provider.dart';
import 'package:titan/purchases/providers/seller_provider.dart';
import 'package:titan/purchases/providers/tag_list_provider.dart';
import 'package:titan/purchases/providers/ticket_id_provider.dart';
import 'package:titan/purchases/router.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TicketCard extends HookConsumerWidget {
  const TicketCard({
    super.key,
    required this.ticket,
    required this.product,
    required this.onClicked,
  });

  final TicketGenerator ticket;
  final Product product;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final seller = ref.watch(sellerProvider);
    final ticketIdNotifier = ref.read(ticketIdProvider.notifier);
    final productIdNotifier = ref.read(productIdProvider.notifier);
    final tagListNotifier = ref.read(tagListProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: onClicked,
        child: CardLayout(
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${ticket.maxUse} scan${ticket.maxUse > 1 ? 's' : ""} maximun - Valide jusqu'au ${DateFormat.yMd(locale).format(ticket.expiration)}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await tokenExpireWrapper(ref, () async {
                    ticketIdNotifier.setTicketId(ticket.id);
                    productIdNotifier.setProductId(product.id);
                    tagListNotifier.loadTags(seller.id, product.id, ticket.id);
                    QR.to(PurchasesRouter.root + PurchasesRouter.userList);
                  });
                },
                child: const HeroIcon(HeroIcons.listBullet),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
