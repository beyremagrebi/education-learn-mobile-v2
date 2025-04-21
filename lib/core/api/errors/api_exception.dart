class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  ApiException.networkError({
    this.message = 'Network error, please check your internet connection',
    this.statusCode,
  });

  ApiException.networkTimeout({
    this.message = 'Network timeout',
    this.statusCode,
  });

  @override
  String toString() {
    return message;
  }
}
