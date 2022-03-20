class TaskUseCaseException implements Exception {
  final String message;
  TaskUseCaseException({
    required this.message,
  });
}
