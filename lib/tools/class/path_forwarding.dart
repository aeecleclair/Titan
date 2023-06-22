class PathForwarding {
  final String path;
  final bool isForwarding;
  final bool canForward;
  PathForwarding({
    required this.path,
    required this.isForwarding,
    required this.canForward,
  });

  PathForwarding copyWith({
    String? path,
    bool? isForwarding,
    bool? canForward,
  }) {
    return PathForwarding(
      path: path ?? this.path,
      isForwarding: isForwarding ?? this.isForwarding,
      canForward: canForward ?? this.canForward,
    );
  }

  @override
  String toString() {
    return 'PathForwarding(path: $path, isForwarding: $isForwarding,canForward: $canForward, )';
  }

  PathForwarding.empty() : this(path: '', isForwarding: false, canForward: false);
}
