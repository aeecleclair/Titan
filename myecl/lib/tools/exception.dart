enum ErrorType {
  tokenExpire,
  notFound,
}

class AppException implements Exception {
  ErrorType type;
  String message;
  AppException(this.type, this.message);
}
