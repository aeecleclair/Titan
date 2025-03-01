import 'package:myecl/generated/openapi.models.swagger.dart';

extension $Recommendation on Recommendation {
 RecommendationBase toRecommendationBase() {
    return RecommendationBase(
      title: title,
      description: description,
      summary: summary,
      code: code,
    );
  }
}