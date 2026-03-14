import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
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

class _ShotgunContent extends StatelessWidget {
  const _ShotgunContent({required this.shotgun});

  final Shotgun shotgun;

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat.yMMMd('fr').format(shotgun.date);

    return SingleChildScrollView(
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
                  if (shotgun.prices.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Tarifs',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorConstants.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...shotgun.prices.values
                        .where((p) => p.trim().isNotEmpty)
                        .map(
                          (price) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              price.trim(),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: ColorConstants.tertiary),
                            ),
                          ),
                        ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
