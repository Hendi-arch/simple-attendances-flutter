/// Extend this class to implement a new type of exception.
abstract class BaseException implements Exception {
  final String message;

  BaseException(this.message);

  @override
  String toString() {
    return message;
  }
}

class GenericException extends BaseException {
  final int code;

  GenericException(String message, this.code) : super(message);

  @override
  String toString() {
    return 'GenericException: message: $message, code: $code';
  }
}