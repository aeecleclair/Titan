class PathForwarding {
  final String path;
  final bool isLoggedIn;
  PathForwarding({
    required this.path,
    required this.isLoggedIn,
  });

  PathForwarding copyWith({
    String? path,
    bool? isLoggedIn,
  }) {
    return PathForwarding(
      path: path ?? this.path,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  String toString() {
    return 'PathForwarding(path: $path, isForwarding: $isLoggedIn)';
  }

  PathForwarding.empty() : this(path: '/', isLoggedIn: false);
}
