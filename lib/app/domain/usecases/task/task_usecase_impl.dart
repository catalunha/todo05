import 'package:todo05/app/data/datasources/firebase/task/task_repository_firebase_impl.dart';
import 'package:todo05/app/data/datasources/hive/task/task_repository_impl.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/models/task/task_model.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase.dart';
import 'package:todo05/app/domain/usecases/user/user_service.dart';

class TaskUseCaseImp implements TaskUseCase {
  TaskRepository _taskRepository;
  UserService _userService;

  TaskUseCaseImp({
    required TaskRepository taskRepository,
    required UserService userService,
  })  : _taskRepository = taskRepository,
        _userService = userService;

  @override
  Future<void> create(TaskModel taskModel) {
    _taskRepository.setUserUuid(_userService.userModel.uuid);
    return _taskRepository.create(taskModel);
  }

  @override
  Future<List<TaskModel>> readAll() {
    _taskRepository.setUserUuid(_userService.userModel.uuid);

    return _taskRepository.readAll();
  }

  @override
  Future<TaskModel?> readByUuid(String uuid) {
    _taskRepository.setUserUuid(_userService.userModel.uuid);

    return _taskRepository.readByUuid(uuid);
  }

  @override
  Future<List<TaskModel>> readByPeriod(
      {required DateTime start, DateTime? end}) {
    _taskRepository.setUserUuid(_userService.userModel.uuid);

    return _taskRepository.readByPeriod(start: start, end: end);
  }

  @override
  Future<void> update(TaskModel taskModel) {
    _taskRepository.setUserUuid(_userService.userModel.uuid);

    return _taskRepository.update(taskModel);
  }

  @override
  Future<void> deleteAll() {
    _taskRepository.setUserUuid(_userService.userModel.uuid);

    return _taskRepository.deleteAll();
  }

  @override
  Future<void> deleteByUuid(String uuid) {
    _taskRepository.setUserUuid(_userService.userModel.uuid);

    return _taskRepository.deleteByUuid(uuid);
  }
}
