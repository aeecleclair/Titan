import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tickets/class/session_form_entry.dart';

class SessionsFormNotifier extends StateNotifier<SessionsFormState> {
  SessionsFormNotifier() : super(SessionsFormState());

  void addEntry() {
    state = SessionsFormState(
      entries: [...state.entries, const SessionFormEntry()],
    );
  }

  void removeEntry(int index) {
    if (state.entries.length <= 1) return;
    state = SessionsFormState(entries: [...state.entries]..removeAt(index));
  }

  void updateLabel(int index, String label) {
    state = SessionsFormState(
      entries: [
        for (var i = 0; i < state.entries.length; i++)
          i == index
              ? state.entries[i].copyWith(label: label)
              : state.entries[i],
      ],
    );
  }

  void updateStartDatetime(int index, DateTime startDatetime) {
    state = SessionsFormState(
      entries: [
        for (var i = 0; i < state.entries.length; i++)
          i == index
              ? state.entries[i].copyWith(startDatetime: startDatetime)
              : state.entries[i],
      ],
    );
  }

  void updateQuota(int index, String quota) {
    state = SessionsFormState(
      entries: [
        for (var i = 0; i < state.entries.length; i++)
          i == index
              ? state.entries[i].copyWith(quota: quota)
              : state.entries[i],
      ],
    );
  }

  void clearSessionsForm() {
    state = SessionsFormState();
  }

  List<Session> buildSessions() {
    return state.entries
        .map(
          (entry) => Session(
            id: '',
            name: entry.label.trim(),
            startDatetime: entry.startDatetime ?? DateTime.now(),
            quota: entry.quota.trim().isEmpty
                ? null
                : int.tryParse(entry.quota.trim()),
          ),
        )
        .toList();
  }
}

final sessionsFormProvider =
    StateNotifierProvider.autoDispose<SessionsFormNotifier, SessionsFormState>((
      ref,
    ) {
      return SessionsFormNotifier();
    });
