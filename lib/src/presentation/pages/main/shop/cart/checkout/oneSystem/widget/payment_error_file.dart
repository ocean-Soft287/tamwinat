class ValidationError {
  late String message;
  Map<String, dynamic>? errors;

  ValidationError(this.message, this.errors);
  ValidationError.messageOnly(this.message);
}

class UnspecifiedError {
  final String message;

  UnspecifiedError(this.message);
}

class UnprocessableTokenError {
  final message = 'The Apple Pay token is unprocessable.';

  UnprocessableTokenError();
}

class TimeoutError {
  static const String type = 'timeout_error';

  final message = 'Request timed out.';

  TimeoutError();
}

class PaymentCanceledError {
  final message = 'user canceled payment.';

  PaymentCanceledError();
}

class NetworkError {
  static const String type = 'network_error';

  final message = 'Network error.';

  NetworkError();
}

class AuthError {
  final String message;

  AuthError(this.message);
}

class ApiError {
  final String message;

  ApiError(this.message);
}