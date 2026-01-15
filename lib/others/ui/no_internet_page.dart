import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/is_connected_provider.dart';
import 'package:titan/home/router.dart';
import 'package:titan/others/tools/constants.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:qlevar_router/qlevar_router.dart';

class NoInternetPage extends HookConsumerWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(isConnectedProvider);
    final isConnectedNotifier = ref.watch(isConnectedProvider.notifier);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height * 0.90,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeroIcon(HeroIcons.signalSlash, size: 150),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "${OthersTextConstants.unableToConnectToServer} ${Repository.host}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(OthersTextConstants.checkInternetConnection),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  isConnectedNotifier.isInternet();
                  if (isConnected) {
                    QR.to(HomeRouter.root);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        ColorConstants.gradient1,
                        ColorConstants.gradient2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.gradient1.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HeroIcon(
                        HeroIcons.arrowPath,
                        size: 35,
                        color: Colors.white,
                      ),
                      Text(
                        OthersTextConstants.retry,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
