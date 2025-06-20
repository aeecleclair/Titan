import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/service/class/topic.dart';
import 'package:myecl/service/repositories/notification_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TopicsProvider extends ListNotifier<Topic> {
  final NotificationRepository notificationRepository;
  TopicsProvider({required this.notificationRepository})
    : super(const AsyncValue.loading());

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
      final notificationRepository = NotificationRepository(ref);
      TopicsProvider notifier = TopicsProvider(
        notificationRepository: notificationRepository,
      );
      notifier.getTopics();
      return notifier;
    });
