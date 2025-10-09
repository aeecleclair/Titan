enum ErrorType { tokenExpire, notFound, invalidData, conflict }

class AppException implements Exception {
  ErrorType type;
  String message;
  AppException(this.type, this.message);

  @override
  String toString() {
    return "${type.toString().split('.')[1]} : $message";
  }
}
