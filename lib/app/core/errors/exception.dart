class LocalDatabaseException implements Exception {
  final String message;

  const LocalDatabaseException({
    required this.message,
  });
}

class CachedException implements Exception {
  final String message;

  const CachedException(
    String errorMessage, {
    required this.message,
  });
}
