import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ResultNotifier
    extends ListNotifierAPI<AppModulesCampaignSchemasCampaignResult> {
  final Openapi resultRepository;
  ResultNotifier({required this.resultRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AppModulesCampaignSchemasCampaignResult>>>
      loadResult() async {
    return await loadList(resultRepository.campaignResultsGet);
  }
}

final resultProvider = StateNotifierProvider<ResultNotifier,
    AsyncValue<List<AppModulesCampaignSchemasCampaignResult>>>((ref) {
  final resultRepository = ref.watch(repositoryProvider);
  final resultNotifier = ResultNotifier(resultRepository: resultRepository);
  tokenExpireWrapperAuth(ref, () async {
    await resultNotifier.loadResult();
  });
  return resultNotifier;
});
