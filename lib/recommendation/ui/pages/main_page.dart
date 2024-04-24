import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/recommendation/class/recommendation.dart';
import 'package:myecl/recommendation/providers/is_recommendation_admin_provider.dart';
import 'package:myecl/recommendation/providers/recommendation_list_provider.dart';
import 'package:myecl/recommendation/providers/recommendation_provider.dart';
import 'package:myecl/recommendation/router.dart';
import 'package:myecl/recommendation/ui/widgets/recommendation_card_layout.dart';
import 'package:myecl/recommendation/ui/widgets/recommendation_card_list.dart';
import 'package:myecl/recommendation/ui/widgets/recommendation_template.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/shimmer.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RecommendationMainPage extends HookConsumerWidget {
  const RecommendationMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationNotifier = ref.watch(recommendationProvider.notifier);
    final recommendationList = ref.watch(recommendationListProvider);
    final recommendationListNotifier =
        ref.watch(recommendationListProvider.notifier);
    final shimmerRecommendation =
        List.generate(10, (index) => Recommendation.empty());

    return RecommendationTemplate(
      child: RefreshIndicator(
        onRefresh: () async {
          await recommendationListNotifier.loadRecommendation();
        },
        child: AsyncChild(
          value: recommendationList,
          builder: (context, value) {
            final recommendations = value
              ..sort((a, b) => b.creation!.compareTo(a.creation!));
            return RecommendationCardList(
              plusButtonOnTap: () {
                recommendationNotifier
                    .setRecommendation(Recommendation.empty());
                QR.to(
                  RecommendationRouter.root + RecommendationRouter.addEdit,
                );
              },
              recommendations: recommendations,
              isLoading: false,
            );
          },
          loadingBuilder: (context) => Shimmer(
            child: RecommendationCardList(
              plusButtonOnTap: () {
                recommendationNotifier
                    .setRecommendation(Recommendation.empty());
                QR.to(
                  RecommendationRouter.root + RecommendationRouter.addEdit,
                );
              },
              recommendations: shimmerRecommendation,
              isLoading: true,
            ),
          ),
        ),
      ),
    );
  }
}
