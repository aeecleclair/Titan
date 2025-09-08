import 'dart:core';

class Information {
  final String facebookUrl;
  final String forumUrl;
  final String description;
  final String contact; //UUID

  Information({
    required this.facebookUrl,
    required this.forumUrl,
    required this.description,
    required this.contact,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'facebook_url': facebookUrl,
      'forum_url': forumUrl,
      'description': description,
      'contact': contact,
    };
  }

  // Create an object from JSON
  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      facebookUrl: json['facebook_url'],
      forumUrl: json['forum_url'],
      description: json['description'],
      contact: json['contact'],
    );
  }

  Information.empty()
    : forumUrl = "",
      facebookUrl = "",
      contact = "",
      description = "";

  Information copyWith({
    String? forumUrl,
    String? facebookUrl,
    String? contact,
    String? description,
  }) {
    return Information(
      description: description ?? this.description,
      forumUrl: forumUrl ?? this.forumUrl,
      contact: contact ?? this.contact,
      facebookUrl: facebookUrl ?? this.facebookUrl,
    );
  }
}
