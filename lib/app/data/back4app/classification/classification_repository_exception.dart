class ClassificationException implements Exception {
  final int code;
  final String message;
  ClassificationException({
    required this.code,
    required this.message,
  });
}
