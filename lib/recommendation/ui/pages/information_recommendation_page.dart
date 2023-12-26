import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/recommendation/providers/recommendation_provider.dart';
import 'package:myecl/recommendation/ui/pages/main_page/recommendation_card.dart';
import 'package:myecl/recommendation/ui/pages/main_page/recommendation_card_layout.dart';
import 'package:myecl/recommendation/ui/widgets/recommendation_template.dart';

class InformationRecommendationPage extends HookConsumerWidget {
  const InformationRecommendationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendation = ref.watch(recommendationProvider);

    return RecommendationTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            RecommendationCard(
              recommendation: recommendation,
              isMainPage: false,
            ),
            RecommendationCardLayout(
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: Text(
                recommendation.description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
