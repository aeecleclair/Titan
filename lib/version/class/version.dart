class Version {
  Version({
    required this.ready,
    required this.version,
    required this.minimalTitanVersion,
  });
  late final bool ready;
  late final String version;
  late final String minimalTitanVersion;

  Version.fromJson(Map<String, dynamic> json) {
    ready = json['ready'];
    version = json['version'];
    minimalTitanVersion = json['minimal_titan_version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ready'] = ready;
    _data['version'] = version;
    _data['minimal_titan_version'] = minimalTitanVersion;
    return _data;
  }

  Version.empty(
      {this.ready = false, this.version = '', this.minimalTitanVersion = ''});
}
