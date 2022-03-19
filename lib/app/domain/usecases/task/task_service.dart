import 'package:todo05/app/domain/models/task/task_model.dart';

abstract class TaskService {
  Future<void> create(TaskModel taskModel);
  Future<List<TaskModel>> readAll();
  Future<TaskModel?> readByUuid(String uuid);
  Future<List<TaskModel>> readByPeriod(
      {required DateTime start, DateTime? end});
  Future<void> update(TaskModel taskModel);
  Future<void> deleteAll();
  Future<void> deleteByUuid(String uuid);
}
