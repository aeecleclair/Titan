import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/cinema/class/session.dart';
import 'package:titan/event/providers/event_list_provider.dart';
import 'package:titan/ticketing/ui/pages/main_page/list_session_ui.dart';

class ListSessionPage extends HookConsumerWidget {
  final bool showSelected;
  final bool editable;
  const ListSessionPage({
    super.key,
    required this.showSelected,
    required this.editable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventListNotifier = ref.read(eventListProvider.notifier);
    final events = ref.watch(eventListProvider);
    final availableSessions = events.maybeWhen<List<Session>>(
      data: (data) => data
          .where((element) => element.usedQuota < element.userQuota)
          .toList(),
      orElse: () => [],
    );

    return Column(
      children: [
        for (var i = 0; i < availableSessions.length; i++)
          ListSessionUi(
            session: availableSessions[i],
            onTap: () {
              {
                if (editable && showSelected) {
                  eventListNotifier.setId(availableSessions[i].id);
                }
              }
            },
          ),
      ],
    );
  }
}
