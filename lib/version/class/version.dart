class Version {
  Version({
    required this.ready,
    required this.version,
    required this.minimalTitanVersion,
  });
  late final bool ready;
  late final String version;
  late final int minimalTitanVersion;

  Version.fromJson(Map<String, dynamic> json) {
    ready = json['ready'] as bool;
    version = json['version'] as String;
    minimalTitanVersion = json['minimal_titan_version_code'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ready'] = ready;
    data['version'] = version;
    data['minimal_titan_version_code'] = minimalTitanVersion;
    return data;
  }

  Version.empty(
      {this.ready = false, this.version = '', this.minimalTitanVersion = 0});
}
