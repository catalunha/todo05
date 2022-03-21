import 'package:todo05/app/data/repositories/task_repository.dart';

abstract class TaskRepositoryFactory {
  TaskRepository produce();
}
