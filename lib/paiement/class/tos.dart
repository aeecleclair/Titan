class TOS {
  final int acceptedTosVersion;
  final int latestTosVersion;
  final String tosContent;

  TOS({
    required this.acceptedTosVersion,
    required this.latestTosVersion,
    required this.tosContent,
  });

  TOS.fromJson(Map<String, dynamic> json)
      : acceptedTosVersion = json['accepted_tos_version'],
        latestTosVersion = json['latest_tos_version'],
        tosContent = json['tos_content'];

  Map<String, dynamic> toJson() {
    return {
      'accepted_tos_version': acceptedTosVersion,
      'latest_tos_version': latestTosVersion,
      'tos_content': tosContent,
    };
  }

  @override
  String toString() {
    return 'TOS{acceptedTosVersion: $acceptedTosVersion, latestTosVersion: $latestTosVersion, tosContent: $tosContent}';
  }

  TOS copyWith({
    int? acceptedTosVersion,
    int? latestTosVersion,
    String? tosContent,
  }) {
    return TOS(
      acceptedTosVersion: acceptedTosVersion ?? this.acceptedTosVersion,
      latestTosVersion: latestTosVersion ?? this.latestTosVersion,
      tosContent: tosContent ?? this.tosContent,
    );
  }

  TOS.empty()
      : this(acceptedTosVersion: 0, latestTosVersion: 0, tosContent: '');
}
