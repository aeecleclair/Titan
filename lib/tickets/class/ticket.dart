import 'dart:developer';

import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/session.dart';

class Ticket {
  Ticket({
    required this.id,
    required this.price,
    required this.userId,
    required this.eventId,
    required this.categoryId,
    required this.sessionId,
    required this.scanned,
    required this.category,
    required this.session,
    required this.userFirstname,
    required this.userName,
  });

  late final String id;
  late final int price;
  late final String userId;
  late final String eventId;
  late final String categoryId;
  late final String sessionId;
  late final bool scanned;
  late final Category category;
  late final Session session;
  late final String userFirstname;
  late final String userName;

  Ticket.fromJson(Map<String, dynamic> json) {
    log('Parsing Ticket from JSON: $json', name: 'Ticket');

    id = json['id']?.toString() ?? '';

    // Price is stored in cents in the backend, convert to euros for the app
    final priceInCents = (json['price'] as num?)?.toInt() ?? 0;
    price = priceInCents ~/ 100;

    userId = json['user_id']?.toString() ?? '';
    eventId = json['event_id']?.toString() ?? '';
    categoryId = json['category_id']?.toString() ?? '';
    sessionId = json['session_id']?.toString() ?? '';
    scanned = json['scanned'] ?? false;

    // Parse category with null safety
    final categoryJson = json['category'];
    if (categoryJson != null && categoryJson is Map<String, dynamic>) {
      try {
        category = Category.fromJson(categoryJson);
      } catch (e) {
        log('Error parsing category: $e', name: 'Ticket');
        category = Category.empty();
      }
    } else {
      log('Category is null or invalid, using empty', name: 'Ticket');
      category = Category.empty();
    }

    // Parse session with null safety
    final sessionJson = json['session'];
    if (sessionJson != null && sessionJson is Map<String, dynamic>) {
      try {
        session = Session.fromJson(sessionJson);
      } catch (e) {
        log('Error parsing session: $e', name: 'Ticket');
        session = Session.empty();
      }
    } else {
      log('Session is null or invalid, using empty', name: 'Ticket');
      session = Session.empty();
    }

    // Parse user name from user object
    final userJson = json['user'];
    if (userJson != null && userJson is Map<String, dynamic>) {
      userFirstname = userJson['firstname']?.toString() ?? '';
      userName =
          userJson['name']?.toString() ??
          userJson['nickname']?.toString() ??
          'Unknown';
    } else {
      userFirstname = '';
      userName = 'Unknown';
    }

    log(
      'Parsed Ticket: id=$id, userFirstname=$userFirstname, userName=$userName, price=$price, scanned=$scanned',
      name: 'Ticket',
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    // Convert euros back to cents for the backend
    data['price'] = price * 100;
    data['user_id'] = userId;
    data['event_id'] = eventId;
    data['category_id'] = categoryId;
    data['session_id'] = sessionId;
    data['scanned'] = scanned;
    data['category'] = category.toJson();
    data['session'] = session.toJson();
    return data;
  }

  Ticket copyWith({
    String? id,
    int? price,
    String? userId,
    String? eventId,
    String? categoryId,
    String? sessionId,
    bool? scanned,
    Category? category,
    Session? session,
    String? userFirstname,
    String? userName,
  }) {
    return Ticket(
      id: id ?? this.id,
      price: price ?? this.price,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      categoryId: categoryId ?? this.categoryId,
      sessionId: sessionId ?? this.sessionId,
      scanned: scanned ?? this.scanned,
      category: category ?? this.category,
      session: session ?? this.session,
      userFirstname: userFirstname ?? this.userFirstname,
      userName: userName ?? this.userName,
    );
  }

  @override
  String toString() {
    return 'Ticket{id: $id, userFirstname: $userFirstname, userName: $userName, price: $price, scanned: $scanned}';
  }
}
