import 'package:flutter_riverpod/flutter_riverpod.dart';

int _createShotgunFormIdCounter = 0;
String _nextFormQuestionId() => 'q_${_createShotgunFormIdCounter++}';

class QcmQuestion {
  QcmQuestion({required this.id, required this.text, required this.choices});

  final String id;
  final String text;
  final List<String> choices;

  QcmQuestion copyWith({String? id, String? text, List<String>? choices}) {
    return QcmQuestion(
      id: id ?? this.id,
      text: text ?? this.text,
      choices: choices ?? List.from(this.choices),
    );
  }
}

class CreateShotgunFormState {
  CreateShotgunFormState({this.title = '', List<QcmQuestion>? questions})
    : questions =
          questions ??
          [
            QcmQuestion(id: _nextFormQuestionId(), text: '', choices: ['', '']),
          ];

  final String title;
  final List<QcmQuestion> questions;

  QcmQuestion? getQuestion(String id) {
    try {
      return questions.firstWhere((q) => q.id == id);
    } catch (_) {
      return null;
    }
  }

  CreateShotgunFormState copyWith({
    String? title,
    List<QcmQuestion>? questions,
  }) {
    return CreateShotgunFormState(
      title: title ?? this.title,
      questions: questions ?? List.from(this.questions),
    );
  }
}

class CreateShotgunFormNotifier extends StateNotifier<CreateShotgunFormState> {
  CreateShotgunFormNotifier() : super(CreateShotgunFormState());

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void addQuestion() {
    state = state.copyWith(
      questions: [
        ...state.questions,
        QcmQuestion(id: _nextFormQuestionId(), text: '', choices: ['', '']),
      ],
    );
  }

  void removeQuestion(String questionId) {
    if (state.questions.length <= 1) return;
    state = state.copyWith(
      questions: state.questions.where((q) => q.id != questionId).toList(),
    );
  }

  void updateQuestionText(String questionId, String value) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        return q.copyWith(text: value);
      }).toList(),
    );
  }

  void addChoice(String questionId) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        return q.copyWith(choices: [...q.choices, '']);
      }).toList(),
    );
  }

  void removeChoice(String questionId, int choiceIndex) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        if (q.choices.length <= 2) return q;
        final newChoices = List<String>.from(q.choices)..removeAt(choiceIndex);
        return q.copyWith(choices: newChoices);
      }).toList(),
    );
  }

  void updateChoice(String questionId, int choiceIndex, String value) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        final newChoices = List<String>.from(q.choices);
        if (choiceIndex >= newChoices.length) return q;
        newChoices[choiceIndex] = value;
        return q.copyWith(choices: newChoices);
      }).toList(),
    );
  }
}

final createShotgunFormProvider =
    StateNotifierProvider.autoDispose<
      CreateShotgunFormNotifier,
      CreateShotgunFormState
    >((ref) => CreateShotgunFormNotifier());
