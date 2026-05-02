import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

import '../class/feedback.dart';

class FeedbackRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "feedback/";

  Future<Feedback> createFeedback(Feedback feedback) async {
    return Feedback.fromJson(
      await create(feedback.toJson(), suffix: "feedbacks"),
    );
  }

  Future<List<Feedback>> getFeedbackList() async {
    return List<Feedback>.from(
      (await getList(suffix: "feedbacks")).map((x) => Feedback.fromJson(x)),
    );
  }

  Future<bool> deleteFeedback(String id) async {
    return await delete("feedbacks/$id");
  }
}

final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return FeedbackRepository()..setToken(token);
});
