import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/recommendation/class/recommendation.dart';
import 'package:myecl/recommendation/ui/widgets/recommendation_card.dart';
import 'package:myecl/recommendation/ui/widgets/recommendation_card_layout.dart';
import 'package:myecl/tools/ui/layouts/shimmer.dart';

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

class RecommendationCardList extends StatelessWidget {
  final void Function()? plusButtonOnTap;
  final List<Recommendation> recommendations;
  final bool isLoading;

  const RecommendationCardList({
    super.key,
    this.plusButtonOnTap,
    required this.recommendations,
    required this.isLoading,
  });

  RecommendationCardList.loading({
    super.key,
    this.plusButtonOnTap,
    this.recommendations = const [],
  }) : isLoading = true;

  @override
  Widget build(BuildContext context) {
    final isAdmin = plusButtonOnTap != null;
    final int itemCount =
        isAdmin ? recommendations.length + 1 : recommendations.length;

    return Shimmer(
      linearGradient: _shimmerGradient,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (isAdmin && index == 0) {
            return GestureDetector(
              onTap: plusButtonOnTap,
              child: const RecommendationCardLayout(
                child: Center(
                  child: HeroIcon(
                    HeroIcons.plus,
                    size: 50,
                  ),
                ),
              ),
            );
          }
          return ShimmerLoading(
            isLoading: isLoading,
            child: isLoading
                ? const RecommendationCardLayout(
                    child: Center(
                      child: SizedBox(
                        height: 50,
                      ),
                    ),
                  )
                : RecommendationCard(
                    recommendation: recommendations[index - 1],
                    isMainPage: true,
                  ),
          );
        },
      ),
    );
  }
}
