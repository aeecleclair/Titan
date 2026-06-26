import 'package:titan/generated/openapi.models.swagger.dart';

extension $QuestionAdmin on QuestionAdmin {
  // The generated payload serialises nulls, so every field has to be sent back
  // or the backend would clear the ones the form does not edit.
  QuestionUpdate toQuestionUpdate() => QuestionUpdate(
    question: question,
    answerType: answerType,
    price: price,
    required: required,
    disabled: disabled,
  );
}

extension $Question on Question {
  /// The create endpoint answers with a [Question]; the event holds
  /// [QuestionAdmin]. The two carry the same fields.
  QuestionAdmin toQuestionAdmin() => QuestionAdmin(
    id: id,
    eventId: eventId,
    question: question,
    answerType: answerType,
    price: price,
    required: required,
    disabled: disabled,
  );
}
