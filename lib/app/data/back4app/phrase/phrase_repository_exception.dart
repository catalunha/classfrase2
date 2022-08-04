class PhraseRepositoryException implements Exception {
  final int code;
  final String message;
  PhraseRepositoryException({
    required this.code,
    required this.message,
  });
}
