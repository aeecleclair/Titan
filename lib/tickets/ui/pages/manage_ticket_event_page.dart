import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';
import 'package:titan/tickets/providers/store_tickets_list_provider.dart';
import 'package:titan/tickets/router.dart';
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
      myStores.value?.isNotEmpty ?? false ? myStores.value?.first : null,
    );

    useEffect(() {
      if (selectedStore.value == null &&
          myStores.hasValue &&
          (myStores.value?.isNotEmpty ?? false)) {
        selectedStore.value = myStores.value?.first;
      }
      return null;
    }, [myStores]);

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () =>
                      QR.to(TicketsRouter.root + TicketsRouter.create),
                  icon: const HeroIcon(
                    HeroIcons.plus,
                    size: 22,
                    color: ColorConstants.main,
                  ),
                  tooltip: l10n.ticketsNewTicketing,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: HorizontalMultiSelect<UserStore>(
              items: myStores.value ?? [],
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
                          l10n.ticketsNoTicketingForStore,
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
