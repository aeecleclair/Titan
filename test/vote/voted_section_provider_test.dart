// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';

void main() {
  group('VotePageNotifier', () {
    test('initial state should be VotePage.main', () {
      final container = ProviderContainer();
      final votePageNotifier = container.read(votePageProvider.notifier);

      expect(votePageNotifier.state, VotePage.main);
    });

    test('setVotePage should update state', () {
      final container = ProviderContainer();
      final votePageNotifier = container.read(votePageProvider.notifier);

      votePageNotifier.setVotePage(VotePage.admin);

      expect(votePageNotifier.state, VotePage.admin);
    });
  });
}
