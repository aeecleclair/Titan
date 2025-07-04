import 'package:flutter/material.dart';

class FeedItem {
  final String title;
  final String subtitle;
  final DateTime date;
  final String? location;
  final String? imageUrl;
  final bool isTerminated;
  final bool needsRegistration;
  final int? participantsCount;
  final VoidCallback? onRegister;

  const FeedItem({
    required this.title,
    required this.subtitle,
    required this.date,
    this.location,
    this.imageUrl,
    this.isTerminated = false,
    this.needsRegistration = false,
    this.participantsCount,
    this.onRegister,
  });

  static List<FeedItem> getFakeItems() {
    return [
      FeedItem(
        title: 'Weekly diplo',
        subtitle: '55€',
        date: DateTime(2025, 12, 18),
      ),
      FeedItem(
        title: 'H11',
        subtitle: '19:30 - 20:30 • Foyer',
        date: DateTime(2025, 11, 8),
        isTerminated: true,
        needsRegistration: true,
        participantsCount: 33,
        onRegister: () {},
      ),
      FeedItem(
        title: 'Weekly diplo',
        subtitle: '55€',
        date: DateTime(2025, 10, 31),
      ),
    ];
  }
}
