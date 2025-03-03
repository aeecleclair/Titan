import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/recommendation/providers/is_recommendation_admin_provider.dart';
import 'package:myecl/recommendation/providers/recommendation_list_provider.dart';
import 'package:myecl/recommendation/providers/recommendation_provider.dart';
import 'package:myecl/recommendation/router.dart';
import 'package:myecl/recommendation/ui/components/recommendation_card.dart';
import 'package:myecl/recommendation/ui/components/recommendation_card_layout.dart';
import 'package:myecl/recommendation/ui/components/recommendation_template.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RecommendationMainPage extends HookConsumerWidget {
  const RecommendationMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecommendationAdmin = ref.watch(isRecommendationAdminProvider);
    final recommendationNotifier = ref.watch(recommendationProvider.notifier);
    final recommendationList = ref.watch(recommendationListProvider);
    final recommendationListNotifier =
        ref.watch(recommendationListProvider.notifier);

    return RecommendationTemplate(
      child: Refresher(
        onRefresh: () async {
          await recommendationListNotifier.loadRecommendation();
        },
        child: AsyncChild(
          value: recommendationList,
          builder: (context, data) => Column(
            children: [
              const SizedBox(height: 30),
              if (isRecommendationAdmin)
                GestureDetector(
                  onTap: () {
                    recommendationNotifier
                        .setRecommendation(EmptyModels.empty<Recommendation>());
                    QR.to(
                      RecommendationRouter.root + RecommendationRouter.addEdit,
                    );
                  },
                  child: const RecommendationCardLayout(
                    child: Center(
                      child: HeroIcon(
                        HeroIcons.plus,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ...(data..sort((a, b) => b.creation.compareTo(a.creation))).map(
                (e) => RecommendationCard(
                  recommendation: e,
                  isMainPage: true,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
