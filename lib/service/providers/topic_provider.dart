import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/service/class/topic.dart';
import 'package:titan/service/repositories/notification_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class TopicsProvider extends ListNotifier<Topic> {
  final NotificationRepository notificationRepository =
      NotificationRepository();
  TopicsProvider({required String token}) : super(const AsyncValue.loading()) {
    notificationRepository.setToken(token);
  }

  Future<AsyncValue<List<Topic>>> getTopics() async {
    return await loadList(notificationRepository.getTopics);
  }

  Future<bool> subscribeTopic(Topic topic) async {
    return await update(
      notificationRepository.subscribeTopic,
      (listT, t) => listT..add(t),
      topic,
    );
  }

  Future<bool> unsubscribeTopic(Topic topic) async {
    return await update(
      notificationRepository.unsubscribeTopic,
      (listT, t) => listT..remove(t),
      topic,
    );
  }

  Future<bool> toggleSubscription(Topic topic) async {
    return state.maybeWhen(
      data: (data) {
        if (data.contains(topic)) {
          return unsubscribeTopic(topic);
        }
        return subscribeTopic(topic);
      },
      orElse: () => false,
    );
  }

  Future<bool> fakeSubscribeTopic(Topic topic) async {
    return await update((_) async => true, (listT, t) => listT..add(t), topic);
  }

  Future<bool> fakeUnsubscribeTopic(Topic topic) async {
    return await update(
      (_) async => true,
      (listT, t) => listT..remove(t),
      topic,
    );
  }

  Future<bool> fakeToggleSubscription(Topic topic) async {
    return state.maybeWhen(
      data: (data) {
        if (data.contains(topic)) {
          return fakeUnsubscribeTopic(topic);
        }
        return fakeSubscribeTopic(topic);
      },
      orElse: () => false,
    );
  }

  Future subscribeAll() async {
    return await state.maybeWhen(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          subscribeTopic(value[i]);
        }
      },
      orElse: () {},
    );
  }
}

final topicsProvider =
    StateNotifierProvider<TopicsProvider, AsyncValue<List<Topic>>>((ref) {
      final token = ref.watch(tokenProvider);
      TopicsProvider notifier = TopicsProvider(token: token);
      tokenExpireWrapperAuth(ref, () async {
        notifier.getTopics();
      });
      return notifier;
    });
