class LearnRepositoryException implements Exception {
  final int code;
  final String message;
  LearnRepositoryException({
    required this.code,
    required this.message,
  });
}
