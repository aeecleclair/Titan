import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/settings/class/feedback.dart';
import 'package:titan/settings/repositories/feedback_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class FeedbackNotifier extends ListNotifier<Feedback> {
  final FeedbackRepository feedbackRepository;
  FeedbackNotifier({required this.feedbackRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Feedback>>> getFeedbackList() async {
    return await loadList(feedbackRepository.getFeedbackList);
  }
}
