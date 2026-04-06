import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/confirm_button.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/countdown_timer.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/feedback_overlay.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/product_card.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/wallet_balance_card.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';

enum _ModalState { idle, loading, success, canceled }

class PaimentDelegateModal extends HookWidget {
  final String itemTitle;
  final String itemDescription;
  final int itemPrice;
  final DateTime? itemExpirationDate;
  final VoidCallback onConfirm;
  final VoidCallback? onRefuse;
  const PaimentDelegateModal({
    super.key,
    required this.itemTitle,
    required this.itemDescription,
    required this.itemPrice,
    this.itemExpirationDate,
    required this.onConfirm,
    this.onRefuse,
  });

  @override
  Widget build(BuildContext context) {
    final state = useState(_ModalState.idle);
    final isExpired = useState(false);
    final idleHeight = useState<double?>(null);
    final idleKey = useMemoized(() => GlobalKey());
    final expirationDate = useMemoized(
      () => DateTime.now().add(const Duration(minutes: 2)),
    );
    final secondsLeft = useMemoized(
      () => expirationDate.difference(DateTime.now()).inSeconds,
    );

    // Capture the idle content height after first layout
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final renderBox =
            idleKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null && idleHeight.value == null) {
          idleHeight.value = renderBox.size.height;
        }
      });
      return null;
    }, []);

    Future<void> onValidate() async {
      if (isExpired.value || state.value != _ModalState.idle) return;
      state.value = _ModalState.loading;
      onConfirm();
      await Future.delayed(const Duration(milliseconds: 600));
      if (!context.mounted) return;
      state.value = _ModalState.success;
      await Future.delayed(const Duration(milliseconds: 1500));
      if (context.mounted) Navigator.of(context).pop();
    }

    Future<void> onCancel() async {
      if (state.value != _ModalState.idle) return;
      if (onRefuse != null) {
        state.value = _ModalState.loading;
        onRefuse!();
        return;
      }
      state.value = _ModalState.canceled;
      await Future.delayed(const Duration(milliseconds: 1500));
      if (context.mounted) Navigator.of(context).pop();
    }

    final showIdle =
        state.value == _ModalState.idle || state.value == _ModalState.loading;

    return BottomModalTemplate(
      title: AppLocalizations.of(context)!.paiementConfirmYourPurchase,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: showIdle
              ? SingleChildScrollView(
                  key: const ValueKey('idle'),
                  child: Column(
                    key: idleKey,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProductCard(
                        title: itemTitle,
                        description: itemDescription,
                        priceInCents: itemPrice,
                      ),
                      if (secondsLeft > 0) ...[
                        const SizedBox(height: 20),
                        CountdownTimer(
                          totalSeconds: secondsLeft,
                          onFinished: () => isExpired.value = true,
                        ),
                      ],
                      const SizedBox(height: 20),
                      const WalletBalanceCard(),
                      const SizedBox(height: 24),
                      ConfirmButton(
                        totalSeconds: secondsLeft,
                        onConfirm: onValidate,
                        onCancel: onCancel,
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: idleHeight.value,
                  child: FeedbackOverlay(
                    key: ValueKey(state.value),
                    isSuccess: state.value == _ModalState.success,
                  ),
                ),
        ),
      ),
    );
  }
}
