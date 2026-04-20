import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/settings/class/feedback.dart';
import 'package:titan/settings/repositories/feedback_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class FeedbackListNotifier extends ListNotifier<Feedback> {
  final FeedbackRepository feedbackRepository;
  FeedbackListNotifier({required this.feedbackRepository})
    : super(const AsyncValue.loading());

  Future<bool> addFeedback(Feedback feedback) async {
    debugPrint("addfeedback " + feedback.toString());
    var result = await add(
      feedbackRepository.createFeedback,
      feedback,
    ); // ça c'est sensé marcher
    debugPrint("result " + result.toString());
    debugPrint("là c'est sensé avoir marché");
    feedbackRepository.createFeedback(feedback);
    debugPrint("et là c'est la triche");
    return result;
  }

  /* Future<bool> addFeedback(Feedback feedback) async {
    return await add(feedbackRepository.createFeedback, feedback);
  } */

  Future<AsyncValue<List<Feedback>>> getFeedbackList() async {
    return await loadList(feedbackRepository.getFeedbackList);
  }

  Future<bool> deleteFeedback(Feedback feedback) async {
    return await delete(
      feedbackRepository.deleteFeedback,
      (feedbacks, feedback) =>
          feedbacks..removeWhere((b) => b.id == feedback.id),
      feedback.id,
      feedback,
    );
  }
}

final feedbackListProvider =
    StateNotifierProvider<FeedbackListNotifier, AsyncValue<List<Feedback>>>((
      ref,
    ) {
      final feedbackRepository = ref.watch(feedbackRepositoryProvider);
      FeedbackListNotifier notifier = FeedbackListNotifier(
        feedbackRepository: feedbackRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.getFeedbackList();
      });
      return notifier;
    });
