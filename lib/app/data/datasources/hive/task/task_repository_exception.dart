class TaskRepositoryException implements Exception {
  final String message;
  TaskRepositoryException({
    required this.message,
  });
}
