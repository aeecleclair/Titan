class PathForwarding {
  final String path;
  final bool isLoggedIn;
  final Map<String, String>? queryParameters;
  PathForwarding({
    required this.path,
    required this.isLoggedIn,
    this.queryParameters,
  });

  PathForwarding copyWith({
    String? path,
    bool? isLoggedIn,
    Map<String, String>? queryParameters,
  }) {
    return PathForwarding(
      path: path ?? this.path,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      queryParameters: queryParameters ?? this.queryParameters,
    );
  }

  @override
  String toString() {
    return 'PathForwarding(path: $path, isForwarding: $isLoggedIn), queryParameters: $queryParameters';
  }

  PathForwarding.empty() : this(path: '/', isLoggedIn: false);
}
