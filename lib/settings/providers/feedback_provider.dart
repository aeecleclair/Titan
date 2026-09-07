import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/settings/class/feedback.dart';
import 'package:titan/settings/repositories/feedback_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class FeedbackNotifier extends SingleNotifier<Feedback> {
  final FeedbackRepository feedbackRepository;
  FeedbackNotifier({required this.feedbackRepository})
    : super(const AsyncValue.loading());

  Future<bool> addFeedback(Feedback feedback) async {
    var result = await add(feedbackRepository.createFeedback, feedback);
    //await feedbackRepository.createFeedback(feedback);
    return result;
  }
}

final feedbackProvider =
    StateNotifierProvider<FeedbackNotifier, AsyncValue<Feedback>>((ref) {
      final feedbackRepository = ref.watch(feedbackRepositoryProvider);
      FeedbackNotifier notifier = FeedbackNotifier(
        feedbackRepository: feedbackRepository,
      );
      return notifier;
    });
