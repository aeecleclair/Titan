import 'package:flutter/material.dart' hide Feedback;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/settings/class/feedback.dart';

class FeedbackNotifier extends StateNotifier<Feedback> {
  FeedbackNotifier() : super(Feedback.empty());

  void setFeedback(Feedback r) {
    state = r;
  }
}

final FeedbackProvider = StateNotifierProvider<FeedbackNotifier, Feedback>((
  ref,
) {
  return FeedbackNotifier();
});
