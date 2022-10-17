import 'package:flutter_riverpod/flutter_riverpod.dart';

enum VotePage { main, admin }


final votePageProvider = StateNotifierProvider<VotePageNotifier, VotePage>((ref) {
  return VotePageNotifier();
});

class VotePageNotifier extends StateNotifier<VotePage> {
  VotePageNotifier() : super(VotePage.main);

  void setVotePage(VotePage i) {
    state = i;
  }
}
