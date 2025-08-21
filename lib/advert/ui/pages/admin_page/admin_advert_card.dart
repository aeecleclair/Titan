import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';
import 'package:titan/advert/class/advert.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';

class AdminAdvertCard extends HookConsumerWidget {
  final VoidCallback onEdit;
  final Future Function() onDelete;
  final Advert advert;

  const AdminAdvertCard({
    super.key,
    required this.advert,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myAssociations = ref.watch(myAssociationListProvider);
    final myAssociationIdList = myAssociations.map((e) => e.id).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      advert.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      _capitalizeFirst(
                        timeago.format(advert.date, locale: 'fr_short'),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorConstants.tertiary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (myAssociationIdList.contains(advert.associationId))
                  CustomIconButton.secondary(
                    onPressed: onEdit,
                    icon: const HeroIcon(
                      HeroIcons.pencil,
                      color: ColorConstants.tertiary,
                    ),
                  ),
                const SizedBox(width: 20),
                CustomIconButton.danger(
                  onPressed: onDelete,
                  icon: const HeroIcon(
                    HeroIcons.trash,
                    color: ColorConstants.background,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
