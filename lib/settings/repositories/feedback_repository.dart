import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

import '../class/feedback.dart';

//does the requests
class FeedbackRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "feedback/";

  Future<Feedback> createFeedback(Feedback feedback) async {
    return Feedback.fromJson(
      await create(feedback.toJson(), suffix: "feedbacks"),
    );
    debugPrint("ca marche !");
    var json = feedback.toJson();
    debugPrint("json " + json.toString());
    var f = await create(json);
    debugPrint("f " + f.toString());
    return Feedback.fromJson(f); //frr pk ça marche pas
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
