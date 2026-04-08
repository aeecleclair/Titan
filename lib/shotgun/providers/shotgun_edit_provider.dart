import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';

class ShotgunEditNotifier extends StateNotifier<AsyncValue<void>> {
  final ShotgunRepository repository;

  ShotgunEditNotifier({required this.repository})
    : super(const AsyncValue.data(null));

  Future<bool> editShotgun(Shotgun shotgun) async {
    state = const AsyncValue.loading();
    try {
      final result = await repository.editShotgun(shotgun);
      state = const AsyncValue.data(null);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateSession(String eventId, session) async {
    try {
      return await repository.updateSession(eventId, session);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateCategory(String eventId, category) async {
    try {
      return await repository.updateCategory(eventId, category);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateQuestion(
    String eventId,
    String questionId,
    String questionText,
  ) async {
    try {
      return await repository.updateQuestion(eventId, questionId, questionText);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final shotgunEditProvider =
    StateNotifierProvider<ShotgunEditNotifier, AsyncValue<void>>((ref) {
      final token = ref.watch(tokenProvider);
      final repository = ShotgunRepository()..setToken(token);
      return ShotgunEditNotifier(repository: repository);
    });
