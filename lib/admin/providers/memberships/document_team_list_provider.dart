import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/document_team.dart';
import 'package:titan/admin/repositories/documents_teams_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class DocumentTeamListNotifier extends ListNotifier<DocumentTeam> {
  final DocumentTeamsRepository documentTeamRepository;
  DocumentTeamListNotifier({required this.documentTeamRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<DocumentTeam>>> loadMeDocumentTeams() async {
    return await loadList(documentTeamRepository.getMeDocumentTeamsList);
  }
}

final documentTeamListProvider =
    StateNotifierProvider<
      DocumentTeamListNotifier,
      AsyncValue<List<DocumentTeam>>
    >((ref) {
      final documentTeamRepository = ref.watch(documentTeamsRepositoryProvider);
      DocumentTeamListNotifier provider = DocumentTeamListNotifier(
        documentTeamRepository: documentTeamRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadMeDocumentTeams();
      });
      return provider;
    });
