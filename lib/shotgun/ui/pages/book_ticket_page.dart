import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/shotgun/class/category.dart';
import 'package:titan/shotgun/class/checkout.dart';
import 'package:titan/shotgun/class/session.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/providers/checkout_provider.dart';
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
    final timeFormat = DateFormat.Hm('fr');

    final selectedCategory = useState<Category?>(null);
    final selectedSession = useState<Session?>(null);
    final selectedPaymentProvider = useState<String?>('helloasso');
    final checkoutState = ref.watch(checkoutProvider);

    // Debug prints
    debugPrint('DEBUG: checkoutState.isCreating = ${checkoutState.isCreating}');
    debugPrint('DEBUG: selectedCategory.value = ${selectedCategory.value}');
    debugPrint('DEBUG: selectedCategory.value?.id = ${selectedCategory.value?.id}');
    debugPrint('DEBUG: Button disabled = ${checkoutState.isCreating || selectedCategory.value == null}');

    // Update checkout when category or session changes
    final checkout = useState<Checkout>(
      Checkout(
        categoryId: selectedCategory.value?.id ?? '',
        sessionId: selectedSession.value?.id ?? '',
      ),
    );

    // Sync checkout with selection changes
    useEffect(() {
      checkout.value = Checkout(
        categoryId: selectedCategory.value?.id ?? '',
        sessionId: selectedSession.value?.id ?? '',
      );
      return null;
    }, [selectedCategory.value, selectedSession.value]);

    // Handle success/error states
    useEffect(() {
      if (checkoutState.isSuccess && checkoutState.checkout != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Réservation créée avec succès !'),
              backgroundColor: Colors.green,
            ),
          );
          // Reset after showing success
          ref.read(checkoutProvider.notifier).reset();
        });
      } else if (checkoutState.error != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur: ${checkoutState.error}'),
              backgroundColor: Colors.red,
            ),
          );
          // Reset after showing error
          ref.read(checkoutProvider.notifier).reset();
        });
      }
      return null;
    }, [checkoutState.isSuccess, checkoutState.error]);

    final validCategories = shotgun.categories
        .where((c) => c.name.trim().isNotEmpty)
        .toList();
    final validSessions = shotgun.sessions
        .where((s) => s.name.trim().isNotEmpty)
        .toList();

    // Debug categories
    debugPrint('DEBUG: shotgun.categories.length = ${shotgun.categories.length}');
    debugPrint('DEBUG: validCategories.length = ${validCategories.length}');
    for (final c in shotgun.categories) {
      debugPrint('DEBUG: category id=${c.id} name="${c.name}" price=${c.price}');
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Réserver un billet',
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
                            HeroIcon(
                              HeroIcons.ticket,
                              size: 20,
                              color: ColorConstants.main,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              shotgun.name,
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
                Text(
                  'Moyen de paiement',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorConstants.secondary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () =>
                            selectedPaymentProvider.value = 'helloasso',
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: selectedPaymentProvider.value == 'helloasso'
                                ? ColorConstants.main.withValues(alpha: 0.1)
                                : ColorConstants.background2.withValues(
                                    alpha: 0.05,
                                  ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  selectedPaymentProvider.value == 'helloasso'
                                  ? ColorConstants.main
                                  : ColorConstants.mainBorder.withValues(
                                      alpha: 0.3,
                                    ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 28,
                                child: SvgPicture.asset(
                                  'assets/images/helloasso.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'HelloAsso',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color:
                                          selectedPaymentProvider.value ==
                                              'helloasso'
                                          ? ColorConstants.main
                                          : ColorConstants.tertiary,
                                      fontWeight:
                                          selectedPaymentProvider.value ==
                                              'helloasso'
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () => selectedPaymentProvider.value = 'myempay',
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: selectedPaymentProvider.value == 'myempay'
                                ? ColorConstants.main.withValues(alpha: 0.1)
                                : ColorConstants.background2.withValues(
                                    alpha: 0.05,
                                  ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedPaymentProvider.value == 'myempay'
                                  ? ColorConstants.main
                                  : ColorConstants.mainBorder.withValues(
                                      alpha: 0.3,
                                    ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 28,
                                child: Image.asset(
                                  'assets/images/logo_prod.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'myempay',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color:
                                          selectedPaymentProvider.value ==
                                              'myempay'
                                          ? ColorConstants.main
                                          : ColorConstants.tertiary,
                                      fontWeight:
                                          selectedPaymentProvider.value ==
                                              'myempay'
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        checkoutState.isCreating ||
                                selectedCategory.value == null
                            ? null
                            : () async {
                              final notifier = ref.read(
                                checkoutProvider.notifier,
                              );
                              await notifier.createCheckout(
                                checkout.value,
                                shotgun,
                              );
                            },
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
                    child:
                        checkoutState.isCreating
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : const Text(
                              'Réserver',
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
