import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/settings/class/feedback.dart';
import 'package:titan/settings/repositories/feedback_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

//grobal variable
class FeedbackNotifier extends SingleNotifier<Feedback> {
  final FeedbackRepository feedbackRepository;
  FeedbackNotifier({required this.feedbackRepository})
    : super(const AsyncValue.loading());

  Future<bool> addFeedback(Feedback feedback) async {
    return await add((f) async => f, feedback);
  }
}

final feedbackProvider = StateNotifierProvider<FeedbackNotifier, AsyncValue>((
  ref,
) {
  final token = ref.watch(tokenProvider);
  FeedbackNotifier notifier = FeedbackNotifier(token: token);
  return notifier;
});
