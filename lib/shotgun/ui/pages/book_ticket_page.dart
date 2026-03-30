import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/shotgun/class/category.dart';
import 'package:titan/shotgun/class/session.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/providers/shotgun_provider.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class BookTicketPage extends HookConsumerWidget {
  const BookTicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathForwarding = ref.watch(pathForwardingProvider);
    final shotgunId = pathForwarding.queryParameters?['shotgunId'];
    print(shotgunId);

    if (shotgunId == null || shotgunId.isEmpty) {
      return ShotgunTemplate(
        child: Center(
          child: Text(
            'Shotgun non trouvé',
            style: TextStyle(color: ColorConstants.tertiary),
          ),
        ),
      );
    }

    final shotgunAsync = ref.watch(shotgunByIdProvider(shotgunId));

    return ShotgunTemplate(
      child: AsyncChild<Shotgun>(
        value: shotgunAsync,
        builder: (context, shotgun) => _ShotgunContent(shotgun: shotgun),
      ),
    );
  }
}

class _ShotgunContent extends HookConsumerWidget {
  const _ShotgunContent({required this.shotgun});

  final Shotgun shotgun;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormatted = DateFormat.yMMMd('fr').format(shotgun.openDatetime);
    final timeFormat = DateFormat.Hm('fr');

    final selectedCategory = useState<Category?>(null);
    final selectedSession = useState<Session?>(null);

    final validCategories = shotgun.categories
        .where((c) => c.name.trim().isNotEmpty)
        .toList();
    final validSessions = shotgun.sessions
        .where((s) => s.name.trim().isNotEmpty)
        .toList();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Réservation',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorConstants.title,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 0,
                  color: ColorConstants.background2.withValues(alpha: 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: ColorConstants.mainBorder.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                              color: ColorConstants.main,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              dateFormatted,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: ColorConstants.onTertiary),
                            ),
                          ],
                        ),
                        if (validCategories.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          Text(
                            'Catégorie (tarif)',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: ColorConstants.secondary),
                          ),
                          const SizedBox(height: 8),
                          ...validCategories.map((category) {
                            final isSelected =
                                selectedCategory.value?.id == category.id;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: InkWell(
                                onTap: () => selectedCategory.value = category,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorConstants.main.withValues(
                                            alpha: 0.1,
                                          )
                                        : ColorConstants.background2.withValues(
                                            alpha: 0.05,
                                          ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected
                                          ? ColorConstants.main
                                          : ColorConstants.mainBorder
                                                .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isSelected
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_unchecked,
                                        size: 20,
                                        color: isSelected
                                            ? ColorConstants.main
                                            : ColorConstants.tertiary,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          category.name.trim(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color:
                                                    ColorConstants.onTertiary,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        '${category.price}€',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: ColorConstants.main,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                        if (validSessions.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          Text(
                            'Session (horaire)',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: ColorConstants.secondary),
                          ),
                          const SizedBox(height: 8),
                          ...validSessions.map((session) {
                            final isSelected =
                                selectedSession.value?.id == session.id;
                            final sessionTime = timeFormat.format(
                              session.startDatetime,
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: InkWell(
                                onTap: () => selectedSession.value = session,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorConstants.main.withValues(
                                            alpha: 0.1,
                                          )
                                        : ColorConstants.background2.withValues(
                                            alpha: 0.05,
                                          ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected
                                          ? ColorConstants.main
                                          : ColorConstants.mainBorder
                                                .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isSelected
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_unchecked,
                                        size: 20,
                                        color: isSelected
                                            ? ColorConstants.main
                                            : ColorConstants.tertiary,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          '${session.name.trim()} - $sessionTime',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color:
                                                    ColorConstants.onTertiary,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                      if (session.quota > 0)
                                        Text(
                                          '${session.quota} places',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: ColorConstants.tertiary,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ColorConstants.background,
            border: Border(
              top: BorderSide(
                color: ColorConstants.mainBorder.withValues(alpha: 0.3),
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedCategory.value != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorConstants.onTertiary,
                        ),
                      ),
                      Text(
                        '${selectedCategory.value!.price}€',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorConstants.main,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        (selectedCategory.value != null &&
                            selectedSession.value != null)
                        ? () {
                            // TODO: Implement payment
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.main,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: ColorConstants.main.withValues(
                        alpha: 0.3,
                      ),
                    ),
                    child: const Text(
                      'Payer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
