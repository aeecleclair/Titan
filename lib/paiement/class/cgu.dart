class CGU {
  final int acceptedCguVersion;
  final int latestCguVersion;
  final String cguContent;

  CGU({
    required this.acceptedCguVersion,
    required this.latestCguVersion,
    required this.cguContent,
  });

  CGU.fromJson(Map<String, dynamic> json)
      : acceptedCguVersion = json['accepted_cgu_version'],
        latestCguVersion = json['latest_cgu_version'],
        cguContent = json['cgu_content'];

  Map<String, dynamic> toJson() {
    return {
      'accepted_cgu_version': acceptedCguVersion,
      'latest_cgu_version': latestCguVersion,
      'cgu_content': cguContent,
    };
  }

  @override
  String toString() {
    return 'CGU{acceptedCguVersion: $acceptedCguVersion, latestCguVersion: $latestCguVersion, cguContent: $cguContent}';
  }

  CGU copyWith({
    int? acceptedCguVersion,
    int? latestCguVersion,
    String? cguContent,
  }) {
    return CGU(
      acceptedCguVersion: acceptedCguVersion ?? this.acceptedCguVersion,
      latestCguVersion: latestCguVersion ?? this.latestCguVersion,
      cguContent: cguContent ?? this.cguContent,
    );
  }

  CGU.empty()
      : this(acceptedCguVersion: 0, latestCguVersion: 0, cguContent: '');
}
