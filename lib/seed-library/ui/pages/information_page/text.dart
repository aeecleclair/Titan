import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/providers/information_provider.dart';
import 'package:titan/seed-library/providers/is_seed_library_admin_provider.dart';
import 'package:titan/seed-library/router.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/ui/seed_library.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:qlevar_router/qlevar_router.dart';

class InformationPage extends HookConsumerWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final information = ref.watch(informationProvider);
    final isSeedLibraryAdmin = ref.watch(isSeedLibraryAdminProvider);

    return SeedLibraryTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(bottom: 30, left: 20, right: 30),
          child: AsyncChild(
            value: information,
            builder: (context, info) => Column(
              children: [
                if (isSeedLibraryAdmin)
                  GestureDetector(
                    onTap: () {
                      QR.to(
                        SeedLibraryRouter.root +
                            SeedLibraryRouter.information +
                            SeedLibraryRouter.editInformation,
                      );
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: SeedLibraryColorConstants.greenGradient1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        SeedLibraryTextConstants.editInformation,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Text(
                  SeedLibraryTextConstants.information,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()
                      ..shader =
                          const RadialGradient(
                            colors: [
                              SeedLibraryColorConstants.greenGradient1,
                              SeedLibraryColorConstants.textDark,
                            ],
                            center: Alignment.topLeft,
                            radius: 10,
                          ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                          ),
                  ),
                ),
                Text(
                  info.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: SeedLibraryColorConstants.textDark,
                  ),
                ),
                Text(
                  SeedLibraryTextConstants.contact,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: SeedLibraryColorConstants.textDark,
                  ),
                ),
                Text(
                  info.contact,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: SeedLibraryColorConstants.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
