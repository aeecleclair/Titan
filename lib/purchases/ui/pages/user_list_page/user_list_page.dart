import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/providers/product_id_provider.dart';
import 'package:titan/purchases/providers/scanned_users_list_provider.dart';
import 'package:titan/purchases/providers/seller_provider.dart';
import 'package:titan/purchases/providers/tag_list_provider.dart';
import 'package:titan/purchases/providers/ticket_id_provider.dart';
import 'package:titan/purchases/ui/purchases.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class UserListPage extends HookConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketId = ref.watch(ticketIdProvider);
    final productId = ref.watch(productIdProvider);
    final seller = ref.watch(sellerProvider);
    final tagList = ref.watch(tagListProvider);
    final tagListNotifier = ref.read(tagListProvider.notifier);
    final scannedUsersList = ref.watch(scannedUsersListProvider);
    final scannedUsersListNotifier = ref.read(
      scannedUsersListProvider.notifier,
    );
    final selectedTag = useState<String?>(null);
    return PurchasesTemplate(
      child: Refresher(
        onRefresh: () async {
          productId.maybeWhen(
            orElse: () {},
            data: (id) {
              ticketId.maybeWhen(
                orElse: () {},
                data: (ticketId) {
                  tagListNotifier.loadTags(seller.id, id, ticketId);
                },
              );
            },
          );
        },
        child: Column(
          children: [
            const SizedBox(height: 30),
            AsyncChild(
              value: tagList,
              builder: (context, tags) {
                if (tags.isEmpty) {
                  return const Center(child: Text("Aucun tag disponible"));
                }

                return HorizontalListView.builder(
                  height: 40,
                  items: tags,
                  itemBuilder: (context, tag, i) {
                    final selected = tag == selectedTag.value;
                    return ItemChip(
                      selected: selected,
                      onTap: () async {
                        await tokenExpireWrapper(ref, () async {
                          selectedTag.value = tag;
                          productId.maybeWhen(
                            orElse: () {},
                            data: (id) {
                              ticketId.maybeWhen(
                                orElse: () {},
                                data: (ticketId) {
                                  scannedUsersListNotifier.loadUsers(
                                    seller.id,
                                    id,
                                    ticketId,
                                    tag,
                                  );
                                },
                              );
                            },
                          );
                        });
                      },
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            if (selectedTag.value != null)
              AsyncChild(
                value: scannedUsersList,
                builder: (context, users) {
                  if (users.isEmpty) {
                    return const Text("Aucun utilisateur scanné");
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: users
                          .map(
                            (user) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 30,
                              ),
                              child: Text(user.getName()),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
