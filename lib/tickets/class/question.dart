import 'package:titan/tickets/class/answer_type.dart';

class Question {
  Question({
    required this.id,
    required this.eventId,
    required this.question,
    required this.answerType,
    this.price,
    required this.required,
    required this.disabled,
  });

  late final String id;
  late final String eventId;
  late final String question;
  late final AnswerType answerType;
  late final int? price;
  late final bool required;
  late final bool disabled;

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    question = json['question'];
    answerType = AnswerTypeExtension.fromString(json['answer_type']);
    // Price is stored in cents in the backend, convert to euros for the app
    final priceInCents = (json['price'] as num?)?.toInt();
    price = priceInCents != null ? priceInCents ~/ 100 : null;
    required = json['required'] ?? false;
    disabled = json['disabled'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['event_id'] = eventId;
    data['question'] = question;
    data['answer_type'] = answerType.value;
    // Convert euros back to cents for the backend
    data['price'] = price != null ? price! * 100 : null;
    data['required'] = required;
    data['disabled'] = disabled;
    return data;
  }

  Question copyWith({
    String? id,
    String? eventId,
    String? question,
    AnswerType? answerType,
    int? price,
    bool? required,
    bool? disabled,
  }) {
    return Question(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      question: question ?? this.question,
      answerType: answerType ?? this.answerType,
      price: price ?? this.price,
      required: required ?? this.required,
      disabled: disabled ?? this.disabled,
    );
  }

  Question.empty() {
    id = '';
    eventId = '';
    question = '';
    answerType = AnswerType.text;
    price = null;
    required = false;
    disabled = false;
  }

  @override
  String toString() {
    return 'Question{id: $id, eventId: $eventId, question: $question, answerType: $answerType, price: $price, required: $required, disabled: $disabled}';
  }
}
