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
import 'package:myecl/recommendation/ui/widgets/shimmer.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class RecommendationMainPage extends HookConsumerWidget {
  const RecommendationMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationNotifier = ref.watch(recommendationProvider.notifier);
    final recommendationList = ref.watch(recommendationListProvider);
    final shimmerRecommendation =
        List.generate(10, (index) => Recommendation.empty());

    return RecommendationTemplate(
      child: recommendationList.when(
        data: (data) {
          final recommendations = data
            ..sort((a, b) => b.creation!.compareTo(a.creation!));
          return RecommendationCardList(
            plusButtonOnTap: () {
              recommendationNotifier.setRecommendation(Recommendation.empty());
              QR.to(
                RecommendationRouter.root + RecommendationRouter.addEdit,
              );
            },
            recommendations: recommendations,
            isLoading: false,
          );
        },
        loading: () => Shimmer(
          linearGradient: _shimmerGradient,
          child: RecommendationCardList(
            plusButtonOnTap: () {
              recommendationNotifier.setRecommendation(Recommendation.empty());
              QR.to(
                RecommendationRouter.root + RecommendationRouter.addEdit,
              );
            },
            recommendations: shimmerRecommendation,
            isLoading: true,
          ),
        ),
        error: (error, stack) => Center(
          child: Text("Error: $error"),
        ),
      ),
    );
  }
}
