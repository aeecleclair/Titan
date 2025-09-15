import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/association_logo_provider.dart';
import 'package:titan/admin/providers/associations_logo_map_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';

class AssociationItem extends ConsumerWidget {
  final String name, avatarName, associationId;
  final bool selected;
  final VoidCallback onTap;
  const AssociationItem({
    super.key,

    required this.name,
    required this.onTap,
    required this.selected,
    required this.avatarName,
    required this.associationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationLogo = ref.watch(
      associationLogoMapProvider.select((value) => value[associationId]),
    );
    final associationLogoMapNotifier = ref.watch(
      associationLogoMapProvider.notifier,
    );
    final associationLogoNotifier = ref.watch(associationLogoProvider.notifier);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: AutoLoaderChild(
                group: associationLogo,
                notifier: associationLogoMapNotifier,
                mapKey: associationId,
                loader: (associationId) =>
                    associationLogoNotifier.getAssociationLogo(associationId),
                dataBuilder: (context, data) => Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selected
                        ? Border.all(color: ColorConstants.tertiary, width: 3)
                        : null,
                    image: DecorationImage(
                      image: data.first.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                orElseBuilder: (context, stack) => Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selected
                        ? Border.all(color: ColorConstants.tertiary, width: 3)
                        : null,
                    color: Colors.grey.shade100,
                  ),
                  child: Center(
                    child: Text(
                      avatarName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: selected
                            ? ColorConstants.onTertiary
                            : ColorConstants.tertiary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 55,
              child: AutoSizeText(
                name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: selected
                      ? ColorConstants.onTertiary
                      : ColorConstants.tertiary,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
