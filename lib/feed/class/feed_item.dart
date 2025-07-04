import 'package:flutter/material.dart';

enum FeedItemType {
  event,
  action,
  announcement,
}

class FeedItem {
  final FeedItemType type;
  final String title;
  final String subtitle;
  final DateTime date;
  final String? location;
  final String? imageUrl;
  final bool isTerminated;
  final bool isOngoing;
  final bool needsRegistration;
  final int? participantsCount;
  final VoidCallback? onRegister;

  const FeedItem({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.date,
    this.location,
    this.imageUrl,
    this.isTerminated = false,
    this.isOngoing = false,
    this.needsRegistration = false,
    this.participantsCount,
    this.onRegister,
  });

  static List<FeedItem> getFakeItems() {
    return [
      FeedItem(
        type: FeedItemType.announcement,
        title: 'Weekly diplo',
        subtitle: '55€',
        date: DateTime(2025, 12, 18),
      ),
      FeedItem(
        type: FeedItemType.event,
        title: 'H11',
        subtitle: '19:30 - 20:30 • Foyer',
        date: DateTime(2025, 11, 8),
        isTerminated: true,
        needsRegistration: true,
        participantsCount: 33,
        onRegister: () {},
      ),
      FeedItem(
        type: FeedItemType.action,
        title: 'Campagne',
        subtitle: 'Jusqu\'à minuit',
        date: DateTime(2025, 11, 8),
        isOngoing: true,
        needsRegistration: true,
        participantsCount: 33,
        onRegister: () {},
      ),
    ];
  }
}
