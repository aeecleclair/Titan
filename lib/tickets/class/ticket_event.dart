import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/question.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tools/functions.dart';

enum TicketEventStatus { open, closed, upcoming, disabled }

class TicketEvent {
  TicketEvent({
    required this.id,
    required this.name,
    required this.storeId,
    required this.quota,
    required this.openDatetime,
    required this.closeDatetime,
    required this.sessions,
    required this.categories,
    required this.questions,
    this.disabled = false,
    this.ticketsInCheckout = 0,
    this.ticketsSold = 0,
    this.soldOut = false,
  });
  late final String id;
  late final String name;
  late final String? storeId;
  late final int? quota;
  late final DateTime openDatetime;
  late final DateTime? closeDatetime;
  late final List<Session> sessions;
  late final List<Category> categories;
  late final List<Question> questions;
  late final bool disabled;
  late final int ticketsInCheckout;
  late final int ticketsSold;
  late final bool soldOut;

  TicketEventStatus get status {
    if (disabled) return TicketEventStatus.disabled;
    final now = DateTime.now();
    if (closeDatetime != null && closeDatetime!.isBefore(now)) {
      return TicketEventStatus.closed;
    }
    if (openDatetime.isAfter(now)) return TicketEventStatus.upcoming;
    return TicketEventStatus.open;
  }

  TicketEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['store_id'] as String?;
    quota = json['quota'];
    openDatetime = processDateFromAPI(json['open_datetime']);
    closeDatetime = json['close_datetime'] != null
        ? processDateFromAPI(json['close_datetime'])
        : null;
    disabled = json['disabled'] ?? false;
    ticketsInCheckout = (json['tickets_in_checkout'] as num?)?.toInt() ?? 0;
    ticketsSold = (json['tickets_sold'] as num?)?.toInt() ?? 0;
    sessions =
        (json['sessions'] as List<dynamic>?)
            ?.map((e) => Session.fromJson(e))
            .whereType<Session>()
            .toList() ??
        [];
    categories =
        (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e))
            .whereType<Category>()
            .toList() ??
        [];
    questions =
        (json['questions'] as List<dynamic>?)
            ?.map((e) => Question.fromJson(e))
            .whereType<Question>()
            .toList() ??
        [];
    soldOut = json['sold_out'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (storeId != null) {
      data['store_id'] = storeId;
    }
    data['quota'] = quota;
    data['open_datetime'] = processDateToAPI(openDatetime);
    data['close_datetime'] = closeDatetime != null
        ? processDateToAPI(closeDatetime!)
        : null;
    data['sessions'] = sessions.map((e) => e.toJson()).toList();
    data['categories'] = categories.map((e) => e.toJson()).toList();
    data['questions'] = questions.map((e) => e.toJson()).toList();
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'name': name,
      'quota': quota,
      'open_datetime': processDateToAPI(openDatetime),
      'close_datetime': closeDatetime != null
          ? processDateToAPI(closeDatetime!)
          : null,
      'disabled': disabled,
    };
  }

  TicketEvent copyWith({
    String? id,
    String? name,
    String? storeId,
    int? quota,
    DateTime? openDatetime,
    DateTime? closeDatetime,
    List<Session>? sessions,
    List<Category>? categories,
    List<Question>? questions,
    bool? soldOut,
    bool? disabled,
    int? ticketsInCheckout,
    int? ticketsSold,
  }) {
    return TicketEvent(
      id: id ?? this.id,
      name: name ?? this.name,
      storeId: storeId ?? this.storeId,
      quota: quota ?? this.quota,
      openDatetime: openDatetime ?? this.openDatetime,
      closeDatetime: closeDatetime ?? this.closeDatetime,
      sessions: sessions ?? this.sessions,
      categories: categories ?? this.categories,
      questions: questions ?? this.questions,
      soldOut: soldOut ?? this.soldOut,
      disabled: disabled ?? this.disabled,
      ticketsInCheckout: ticketsInCheckout ?? this.ticketsInCheckout,
      ticketsSold: ticketsSold ?? this.ticketsSold,
    );
  }

  TicketEvent.empty() {
    id = '';
    name = '';
    storeId = '';
    quota = 0;
    openDatetime = DateTime.now();
    closeDatetime = null;
    sessions = [];
    categories = [];
    questions = [];
    disabled = false;
    ticketsInCheckout = 0;
    ticketsSold = 0;
    soldOut = false;
  }

  @override
  String toString() {
    return 'Shotgun{id : $id, name: $name, storeId: $storeId, quota: $quota, openDatetime: $openDatetime, closeDatetime: $closeDatetime, sessions: $sessions, categories: $categories, questions: $questions, soldOut: $soldOut, disabled: $disabled, ticketsInCheckout: $ticketsInCheckout, ticketsSold: $ticketsSold}';
  }
}
