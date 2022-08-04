class UserProfileRepositoryException implements Exception {
  final String code;
  final String message;
  UserProfileRepositoryException({
    required this.code,
    required this.message,
  });
}
