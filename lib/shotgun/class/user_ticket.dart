import 'package:titan/shotgun/class/answer.dart';
import 'package:titan/tools/functions.dart';

class UserTicket {
  UserTicket({
    required this.id,
    required this.eventId,
    required this.categoryId,
    required this.sessionId,
    required this.status,
    required this.paymentType,
    required this.answers,
    required this.ticketDate,
    required this.eventName,
    required this.categoryName,
    required this.sessionDate,
  });

  late final String id;
  late final String eventId;
  late final String categoryId;
  late final String sessionId;
  late final String status;
  late final String paymentType;
  late final List<Answer> answers;
  late final DateTime ticketDate;
  late final String eventName;
  late final String categoryName;
  late final DateTime sessionDate;

  UserTicket.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    eventId = json['event_id'] ?? '';
    categoryId = json['category_id'] ?? '';
    sessionId = json['session_id'] ?? '';
    status = json['status'] ?? '';
    paymentType = json['payment_type'] ?? '';
    answers = (json['answers'] as List<dynamic>?)
            ?.map((e) => Answer.fromJson(e))
            .whereType<Answer>()
            .toList() ??
        [];
    ticketDate = json['ticket_date'] != null
        ? processDateFromAPI(json['ticket_date'])
        : DateTime.now();
    eventName = json['event_name'] ?? '';
    categoryName = json['category_name'] ?? '';
    sessionDate = json['session_date'] != null
        ? processDateFromAPI(json['session_date'])
        : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['event_id'] = eventId;
    data['category_id'] = categoryId;
    data['session_id'] = sessionId;
    data['status'] = status;
    data['payment_type'] = paymentType;
    data['answers'] = answers.map((e) => e.toJson()).toList();
    data['ticket_date'] = processDateToAPI(ticketDate);
    data['event_name'] = eventName;
    data['category_name'] = categoryName;
    data['session_date'] = processDateToAPI(sessionDate);
    return data;
  }

  UserTicket copyWith({
    String? id,
    String? eventId,
    String? categoryId,
    String? sessionId,
    String? status,
    String? paymentType,
    List<Answer>? answers,
    DateTime? ticketDate,
    String? eventName,
    String? categoryName,
    DateTime? sessionDate,
  }) {
    return UserTicket(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      categoryId: categoryId ?? this.categoryId,
      sessionId: sessionId ?? this.sessionId,
      status: status ?? this.status,
      paymentType: paymentType ?? this.paymentType,
      answers: answers ?? this.answers,
      ticketDate: ticketDate ?? this.ticketDate,
      eventName: eventName ?? this.eventName,
      categoryName: categoryName ?? this.categoryName,
      sessionDate: sessionDate ?? this.sessionDate,
    );
  }

  @override
  String toString() {
    return 'UserTicket{id: $id, eventId: $eventId, categoryId: $categoryId, sessionId: $sessionId, status: $status, eventName: $eventName}';
  }
}
