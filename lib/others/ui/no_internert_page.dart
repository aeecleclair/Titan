import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/others/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';

class NoInternetPage extends HookConsumerWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionVerifierNotifier = ref.watch(versionVerifierProvider.notifier);
    return Scaffold(
      body: Refresher(
        onRefresh: () async {
          await versionVerifierNotifier.loadVersion();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HeroIcon(
                  HeroIcons.signalSlash,
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    OthersTextConstants.unableToConnectToServer,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    OthersTextConstants.checkInternetConnection,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () async {
                    await versionVerifierNotifier.loadVersion();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 250,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              ColorConstants.gradient1,
                              ColorConstants.gradient2
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              color: ColorConstants.gradient1.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5))
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        HeroIcon(
                          HeroIcons.arrowPath,
                          size: 25,
                          color: Colors.white,
                        ),
                        Text(OthersTextConstants.retry,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
