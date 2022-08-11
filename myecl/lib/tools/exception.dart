enum ErrorType {
  tokenExpire,
  notFound,
  invalidData
}

class AppException implements Exception {
  ErrorType type;
  String message;
  AppException(this.type, this.message);
}
