import 'package:todo05/app/model/models/task/task_model.dart';
import 'package:todo05/app/model/repositories/task/task_repository.dart';
import 'package:todo05/app/viewmodel/services/task/task_service.dart';

class TaskServiceImp implements TaskService {
  TaskRepository _taskRepository;
  TaskServiceImp({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;

  @override
  Future<void> create(TaskModel taskModel) {
    return _taskRepository.create(taskModel);
  }

  @override
  Future<List<TaskModel>> readAll() {
    return _taskRepository.readAll();
  }

  @override
  Future<TaskModel?> readByUuid(String uuid) {
    return _taskRepository.readByUuid(uuid);
  }

  @override
  Future<List<TaskModel>> readByPeriod(
      {required DateTime start, DateTime? end}) {
    return _taskRepository.readByPeriod(start: start, end: end);
  }

  @override
  Future<void> update(TaskModel taskModel) {
    return _taskRepository.update(taskModel);
  }

  @override
  Future<void> deleteAll() {
    return _taskRepository.deleteAll();
  }

  @override
  Future<void> deleteByUuid(String uuid) {
    return _taskRepository.deleteByUuid(uuid);
  }
}
