import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/settings/class/feedback.dart';
import 'package:titan/settings/repositories/feedback_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class FeedbackListNotifier extends ListNotifier<Feedback> {
  final FeedbackRepository feedbackRepository;
  FeedbackListNotifier({required this.feedbackRepository})
    : super(const AsyncValue.loading());

  Future<bool> addFeedback(Feedback feedback) async {
    debugPrint("addfeedback " + feedback.toString());
    feedbackRepository.createFeedback(feedback);
    var result = await add(feedbackRepository.createFeedback, feedback);
    debugPrint("result " + result.toString());
    return result;
  }

  Future<AsyncValue<List<Feedback>>> getFeedbackList() async {
    return await loadList(feedbackRepository.getFeedbackList);
  }

  // Future<bool> deleteFeedback(Feedback feedback) async {
  //   return await delete(feedbackRepository.delete,
  //   feedbacks, feedback) => feedbacks..removeWhere((i) => i.id == feedback.id),
  //   feedback.id,
  //   feedback)
  // }
}

final feedbackListProvider =
    StateNotifierProvider<FeedbackListNotifier, AsyncValue<List<Feedback>>>((
      ref,
    ) {
      final feedbackRepository = ref.watch(feedbackRepositoryProvider);
      return FeedbackListNotifier(feedbackRepository: feedbackRepository);
    });
