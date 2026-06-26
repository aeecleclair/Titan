import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ResultNotifier
    extends ListNotifierAPI<AppModulesCampaignSchemasCampaignResult> {
  Openapi get resultRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppModulesCampaignSchemasCampaignResult>> build() {
    loadResult();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AppModulesCampaignSchemasCampaignResult>>>
  loadResult() async {
    return await loadList(resultRepository.campaignResultsGet);
  }
}

final resultProvider =
    NotifierProvider<
      ResultNotifier,
      AsyncValue<List<AppModulesCampaignSchemasCampaignResult>>
    >(ResultNotifier.new);
