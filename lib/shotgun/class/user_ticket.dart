import 'dart:developer';

import 'package:titan/shotgun/class/category.dart';
import 'package:titan/shotgun/class/session.dart';

class UserTicket {
  UserTicket({
    required this.id,
    required this.price,
    required this.userId,
    required this.eventId,
    required this.scanned,
    required this.category,
    required this.session,
    required this.eventName,
  });

  late final String id;
  late final int price;
  late final String userId;
  late final String eventId;
  late final bool scanned;
  late final Category category;
  late final Session session;
  late final String eventName;

  UserTicket.fromJson(Map<String, dynamic> json) {
    log('Parsing UserTicket from JSON: $json', name: 'UserTicket');

    id = json['id']?.toString() ?? '';

    // Price is stored in cents in the backend, convert to euros for the app
    final priceInCents = (json['price'] as num?)?.toInt() ?? 0;
    price = priceInCents ~/ 100;

    userId = json['user_id']?.toString() ?? '';
    eventId = json['event_id']?.toString() ?? '';
    scanned = json['scanned'] ?? false;

    // Parse category with null safety
    final categoryJson = json['category'];
    if (categoryJson != null && categoryJson is Map<String, dynamic>) {
      try {
        category = Category.fromJson(categoryJson);
      } catch (e) {
        log('Error parsing category: $e', name: 'UserTicket');
        category = Category.empty();
      }
    } else {
      log('Category is null or invalid, using empty', name: 'UserTicket');
      category = Category.empty();
    }

    // Parse session with null safety
    final sessionJson = json['session'];
    if (sessionJson != null && sessionJson is Map<String, dynamic>) {
      try {
        session = Session.fromJson(sessionJson);
      } catch (e) {
        log('Error parsing session: $e', name: 'UserTicket');
        session = Session.empty();
      }
    } else {
      log('Session is null or invalid, using empty', name: 'UserTicket');
      session = Session.empty();
    }

    // Parse event name from event object
    final eventJson = json['event'];
    if (eventJson != null && eventJson is Map<String, dynamic>) {
      eventName = eventJson['name']?.toString() ?? '';
    } else {
      eventName = '';
    }

    log(
      'Parsed UserTicket: id=$id, eventName=$eventName, price=$price, scanned=$scanned',
      name: 'UserTicket',
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    // Convert euros back to cents for the backend
    data['price'] = price * 100;
    data['user_id'] = userId;
    data['event_id'] = eventId;
    data['scanned'] = scanned;
    data['category'] = category.toJson();
    data['session'] = session.toJson();
    data['event_name'] = eventName;
    return data;
  }

  UserTicket copyWith({
    String? id,
    int? price,
    String? userId,
    String? eventId,
    bool? scanned,
    Category? category,
    Session? session,
    String? eventName,
  }) {
    return UserTicket(
      id: id ?? this.id,
      price: price ?? this.price,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      scanned: scanned ?? this.scanned,
      category: category ?? this.category,
      session: session ?? this.session,
      eventName: eventName ?? this.eventName,
    );
  }

  @override
  String toString() {
    return 'UserTicket{id: $id, eventName: $eventName, price: $price, scanned: $scanned}';
  }
}
