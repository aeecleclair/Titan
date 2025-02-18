import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myecl/paiement/router.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class ConfirmButton extends ConsumerWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocalAuthentication auth = LocalAuthentication();
    return GestureDetector(
      onTap: () async {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Veuillez vous authentifier pour payer',
            authMessages: [
              const AndroidAuthMessages(
                signInTitle: 'L\'authentification est requise pour payer',
                cancelButton: 'Non merci',
              ),
              const IOSAuthMessages(
                cancelButton: 'Non merci',
              ),
            ],);
        if (didAuthenticate) {
          QR.to(PaymentRouter.root + PaymentRouter.pay + PaymentRouter.qr);
        }
      },
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: const HeroIcon(
          HeroIcons.qrCode,
          color: Color(0xff017f80),
          size: 65,
        ),
      ),
    );
  }
}
