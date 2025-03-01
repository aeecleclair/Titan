import 'package:myecl/generated/openapi.models.swagger.dart';

extension $Recommendation on Recommendation {
  RecommendationEdit toRecommendationEdit() {
    return RecommendationEdit(
      title: title,
      description: description,
      summary: summary,
      code: code,
    );
  }
}
