import 'package:titan/tickets/class/answer_type.dart';

class Answer {
  Answer({
    required this.questionId,
    required this.answerType,
    required this.answer,
  });

  late final String questionId;
  late final AnswerType answerType;
  late final dynamic answer;

  String get answerValue => answer.toString();

  Answer.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    answerType = AnswerTypeExtension.fromString(json['answer_type']);
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['answer'] = {'answer_type': answerType.value, 'answer': answer};
    return data;
  }

  Answer copyWith({
    String? questionId,
    AnswerType? answerType,
    dynamic answer,
  }) {
    return Answer(
      questionId: questionId ?? this.questionId,
      answerType: answerType ?? this.answerType,
      answer: answer ?? this.answer,
    );
  }

  Answer.empty() {
    questionId = '';
    answerType = AnswerType.text;
    answer = '';
  }

  @override
  String toString() {
    return 'Answer{questionId: $questionId, answerType: $answerType, answer: $answer}';
  }
}
