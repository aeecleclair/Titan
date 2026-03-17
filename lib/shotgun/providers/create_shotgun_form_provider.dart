import 'package:flutter_riverpod/flutter_riverpod.dart';

enum QuestionType { tariff, quota }

class QcmChoice {
  QcmChoice({required this.text, this.value});

  final String text;
  final double? value;

  QcmChoice copyWith({String? text, double? value}) {
    return QcmChoice(
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'value': value,
    };
  }

  factory QcmChoice.fromMap(Map<String, dynamic> map) {
    return QcmChoice(
      text: map['text'] ?? '',
      value: map['value'] != null ? (map['value'] is double ? map['value'] : map['value'].toDouble()) : null,
    );
  }
}

int _createShotgunFormIdCounter = 0;
String _nextFormQuestionId() => 'q_${_createShotgunFormIdCounter++}';

class QcmQuestion {
  QcmQuestion({
    required this.id,
    required this.text,
    required this.choices,
    this.type = QuestionType.tariff,
  });

  final String id;
  final String text;
  final List<QcmChoice> choices;
  final QuestionType type;

  QcmQuestion copyWith({
    String? id,
    String? text,
    List<QcmChoice>? choices,
    QuestionType? type,
  }) {
    return QcmQuestion(
      id: id ?? this.id,
      text: text ?? this.text,
      choices: choices ?? List.from(this.choices),
      type: type ?? this.type,
    );
  }
}

class CreateShotgunFormState {
  CreateShotgunFormState({this.title = '', List<QcmQuestion>? questions})
    : questions =
        questions ??
        [
          QcmQuestion(
            id: _nextFormQuestionId(),
            text: '',
            choices: [QcmChoice(text: ''), QcmChoice(text: '')],
            type: QuestionType.tariff,
          ),
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
        QcmQuestion(
          id: _nextFormQuestionId(),
          text: '',
          choices: [QcmChoice(text: ''), QcmChoice(text: '')],
          type: QuestionType.tariff,
        ),
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

  void setQuestionType(String questionId, QuestionType type) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        return q.copyWith(type: type);
      }).toList(),
    );
  }

  void addChoice(String questionId) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        return q.copyWith(choices: [...q.choices, QcmChoice(text: '')]);
      }).toList(),
    );
  }

  void removeChoice(String questionId, int choiceIndex) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        if (q.choices.length <= 2) return q;
        final newChoices = List<QcmChoice>.from(q.choices)..removeAt(choiceIndex);
        return q.copyWith(choices: newChoices);
      }).toList(),
    );
  }

  void updateChoice(String questionId, int choiceIndex, String text) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        if (choiceIndex >= q.choices.length) return q;
        final newChoices = List<QcmChoice>.from(q.choices);
        newChoices[choiceIndex] = newChoices[choiceIndex].copyWith(text: text);
        return q.copyWith(choices: newChoices);
      }).toList(),
    );
  }

  void updateChoiceValue(String questionId, int choiceIndex, double? value) {
    state = state.copyWith(
      questions: state.questions.map((q) {
        if (q.id != questionId) return q;
        if (choiceIndex >= q.choices.length) return q;
        final newChoices = List<QcmChoice>.from(q.choices);
        newChoices[choiceIndex] = newChoices[choiceIndex].copyWith(value: value);
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
