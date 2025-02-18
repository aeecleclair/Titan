import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/fund_amount_provider.dart';
import 'package:myecl/paiement/providers/key_service_provider.dart';
import 'package:myecl/tools/functions.dart';

class ConfirmFundButton extends ConsumerWidget {
  const ConfirmFundButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyService = ref.watch(keyServiceProvider);
    final fundAmount = ref.watch(fundAmountProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final enabled = fundAmount.isNotEmpty &&
        double.parse(fundAmount.replaceAll(',', '.')) > 0;

    return GestureDetector(
      onTap: () async {},
      child: Container(
        height: 75,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: enabled
              ? Colors.white
              : Colors.grey.shade200.withValues(alpha: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SvgPicture.asset(
                  'assets/images/helloasso.svg',
                  width: 50,
                  height: 50,
                ),
              ),
              Text(
                "Payer avec HelloAsso",
                style: TextStyle(
                  color: enabled
                      ? const Color(0xff2e2f5e)
                      : const Color(0xff2e2f5e).withValues(alpha: 0.5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
