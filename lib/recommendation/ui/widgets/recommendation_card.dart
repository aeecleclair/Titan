import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/recommendation/class/recommendation.dart';
import 'package:titan/recommendation/providers/is_recommendation_admin_provider.dart';
import 'package:titan/recommendation/providers/recommendation_list_provider.dart';
import 'package:titan/recommendation/providers/recommendation_logo_map_provider.dart';
import 'package:titan/recommendation/providers/recommendation_logo_provider.dart';
import 'package:titan/recommendation/providers/recommendation_provider.dart';
import 'package:titan/recommendation/router.dart';
import 'package:titan/recommendation/tools/constants.dart';
import 'package:titan/recommendation/ui/widgets/recommendation_card_layout.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RecommendationCard extends HookConsumerWidget {
  final Recommendation recommendation;
  final bool isMainPage;

  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.isMainPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecommendationAdmin = ref.watch(isRecommendationAdminProvider);
    final recommendationNotifier = ref.watch(recommendationProvider.notifier);
    final recommendationListNotifier = ref.watch(
      recommendationListProvider.notifier,
    );
    final logo = ref.watch(
      recommendationLogoMapProvider.select(
        (recommendations) => recommendations[recommendation],
      ),
    );
    final recommendationLogoMapNotifier = ref.watch(
      recommendationLogoMapProvider.notifier,
    );
    final recommendationLogoNotifier = ref.watch(
      recommendationLogoProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return AutoLoaderChild(
      group: logo,
      notifier: recommendationLogoMapNotifier,
      mapKey: recommendation,
      loader: (ref) =>
          recommendationLogoNotifier.getRecommendationLogo(recommendation.id!),
      loadingBuilder: (context) => const HeroIcon(HeroIcons.photo),
      dataBuilder: (context, data) => RecommendationCardLayout(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(width: 50, image: data.first.image),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    recommendation.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (recommendation.code != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            recommendation.code!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: recommendation.code!),
                            );
                            displayToastWithContext(
                              TypeMsg.msg,
                              RecommendationTextConstants.copiedCode,
                            );
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                    ),
                  Text(
                    recommendation.summary,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            isMainPage
                ? SizedBox(
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        recommendationNotifier.setRecommendation(
                          recommendation,
                        );
                        QR.to(
                          RecommendationRouter.root +
                              RecommendationRouter.information,
                        );
                      },
                      icon: const HeroIcon(
                        HeroIcons.informationCircle,
                        size: 40,
                      ),
                    ),
                  )
                : SizedBox(
                    width: 50,
                    child: isRecommendationAdmin
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  QR.to(
                                    RecommendationRouter.root +
                                        RecommendationRouter.addEdit,
                                  );
                                },
                                child: const CardButton(
                                  child: HeroIcon(HeroIcons.pencil, size: 25),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  await tokenExpireWrapper(ref, () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => CustomDialogBox(
                                        descriptions: RecommendationTextConstants
                                            .deleteRecommendationConfirmation,
                                        onYes: () async {
                                          final value =
                                              await recommendationListNotifier
                                                  .deleteRecommendation(
                                                    recommendation,
                                                  );
                                          if (value) {
                                            displayToastWithContext(
                                              TypeMsg.msg,
                                              RecommendationTextConstants
                                                  .deletedRecommendation,
                                            );
                                            QR.back();
                                          } else {
                                            displayToastWithContext(
                                              TypeMsg.error,
                                              RecommendationTextConstants
                                                  .deletingRecommendationError,
                                            );
                                          }
                                        },
                                        title: RecommendationTextConstants
                                            .deleteRecommendation,
                                      ),
                                    );
                                  });
                                },
                                child: const CardButton(
                                  color: Colors.black,
                                  child: HeroIcon(
                                    color: Colors.white,
                                    HeroIcons.trash,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
          ],
        ),
      ),
    );
  }
}
