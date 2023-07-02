class PathForwarding {
  final String path;
  final bool isLoggedIn;
  final bool canForward;
  PathForwarding({
    required this.path,
    required this.isLoggedIn,
    required this.canForward,
  });

  PathForwarding copyWith({
    String? path,
    bool? isLoggedIn,
    bool? canForward,
  }) {
    return PathForwarding(
      path: path ?? this.path,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      canForward: canForward ?? this.canForward,
    );
  }

  @override
  String toString() {
    return 'PathForwarding(path: $path, isForwarding: $isLoggedIn,canForward: $canForward, )';
  }

  PathForwarding.empty() : this(path: '', isLoggedIn: false, canForward: false);
}
