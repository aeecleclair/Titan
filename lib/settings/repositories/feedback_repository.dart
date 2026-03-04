import 'package:titan/tools/repository/repository.dart';

import '../class/feedback.dart';

class FeedbackRepository extends Repository {
  Future<Feedback> createFeedback(Feedback feedback) async {
    return Feedback.fromJson(await create(feedback.toJson()));
  }
}
