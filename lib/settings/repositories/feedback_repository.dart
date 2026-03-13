import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

import '../class/feedback.dart';

//does the requests
class FeedbackRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "feedback/feedbacks";

  Future<Feedback> createFeedback(Feedback feedback) async {
    debugPrint("ca marche !");
    var json = feedback.toJson();
    debugPrint("json " + json.toString());
    var f = await create(json);
    debugPrint("f " + f.toString());
    return Feedback.fromJson(f);
  }

  Future<List<Feedback>> getFeedbackList() async {
    return List<Feedback>.from(
      (await getList(suffix: "feedback")).map((x) => Feedback.fromJson(x)),
    );
  }

  // Future<bool> deleteFeedback() async {
  //   return await delete(ff)
  // }
}

final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return FeedbackRepository()..setToken(token);
});
