import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/advert/repositories/advert_topic_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdvertTopicsProvider extends ListNotifier<String> {
  final AdvertTopicRepository advertTopicRepository = AdvertTopicRepository();
  AdvertTopicsProvider({required String token})
      : super(const AsyncValue.loading()) {
    advertTopicRepository.setToken(token);
  }

  Future<AsyncValue<List<String>>> getTopics() async {
    return await loadList(advertTopicRepository.getAdvertTopics);
  }

  Future<bool> subscribeSession(String topic) async {
    return await update(advertTopicRepository.subscribeAdvert,
        (listT, t) => listT..add(t), topic);
  }

  Future<bool> unsubscribeSession(String topic) async {
    return await update(advertTopicRepository.unsubscribeAdvert,
        (listT, t) => listT..remove(t), topic);
  }

  Future<bool> toggleSubscription(String topic) async {
    return state.maybeWhen(
        data: (data) {
          if (data.contains(topic)) {
            return unsubscribeSession(topic);
          }
          return subscribeSession(topic);
        },
        orElse: () => false);
  }
}

final advertTopicsProvider =
    StateNotifierProvider<AdvertTopicsProvider, AsyncValue<List<String>>>((ref) {
  final token = ref.watch(tokenProvider);
  AdvertTopicsProvider notifier = AdvertTopicsProvider(token: token);
  tokenExpireWrapperAuth(ref, () async {
    notifier.getTopics();
  });
  return notifier;
});
