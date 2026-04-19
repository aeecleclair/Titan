import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/class/user_store.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';
import 'package:titan/tickets/providers/store_tickets_list_provider.dart';
import 'package:titan/tickets/ui/components/ticket_event_card.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';

class ManageTicketEventPage extends HookConsumerWidget {
  const ManageTicketEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final myStores = ref.watch(myStoresProvider);
    final storeTicketEventList = ref.watch(storeTicketEventListProvider);
    final storeTicketEventListNotifier = ref.watch(
      storeTicketEventListProvider.notifier,
    );
    final selectedStore = useState<UserStore?>(
      myStores.valueOrNull?.isNotEmpty ?? false
          ? myStores.valueOrNull?.first
          : null,
    );

    // Sélectionner automatiquement le premier store quand la liste charge
    useEffect(() {
      if (selectedStore.value == null &&
          myStores.hasValue &&
          (myStores.valueOrNull?.isNotEmpty ?? false)) {
        selectedStore.value = myStores.valueOrNull?.first;
      }
      return null;
    }, [myStores]);

    // Charger les ticketEvents du store sélectionné au démarrage
    useEffect(() {
      if (selectedStore.value != null) {
        storeTicketEventListNotifier.loadStoreTicketEventList(
          selectedStore.value!.id,
        );
      }
      return null;
    }, [selectedStore.value]);

    return TicketTemplate(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              l10n.ticketsManageTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: HorizontalMultiSelect<UserStore>(
              items: myStores.valueOrNull ?? [],
              selectedItem: selectedStore.value,
              onItemSelected: (store) {
                selectedStore.value = store;
                storeTicketEventListNotifier.loadStoreTicketEventList(store.id);
              },
              itemBuilder: (context, store, index, selected) => Text(
                store.name,
                style: TextStyle(
                  color: selected
                      ? ColorConstants.background
                      : ColorConstants.tertiary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Refresher(
              onRefresh: () {
                if (selectedStore.value == null) {
                  return Future.value();
                }
                return storeTicketEventListNotifier.loadStoreTicketEventList(
                  selectedStore.value!.id,
                );
              },
              controller: ScrollController(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AsyncChild(
                  value: storeTicketEventList,
                  builder: (context, ticketEventList) {
                    if (ticketEventList.isEmpty) {
                      return Center(
                        child: Text(
                          "Hello",
                          style: const TextStyle(
                            color: ColorConstants.tertiary,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ticketEventList.length,
                      itemBuilder: (context, index) {
                        return TicketEventCard(
                          ticketEvent: ticketEventList[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
