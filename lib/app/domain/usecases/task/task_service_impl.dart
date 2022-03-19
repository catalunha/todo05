import 'package:todo05/app/data/datasources/hive/task/task_repository_impl.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/models/task/task_model.dart';
import 'package:todo05/app/domain/usecases/task/task_service.dart';
import 'package:todo05/app/presentation/controllers/user/user_additional_info/usermodel_service.dart';

class TaskServiceImp implements TaskService {
  TaskRepository _taskRepository;
  UserModelService _userModelService;

  TaskServiceImp({
    required TaskRepository taskRepository,
    required UserModelService userModelService,
  })  : _taskRepository = taskRepository,
        _userModelService = userModelService;

  @override
  Future<void> create(TaskModel taskModel) {
    TaskRepositoryImp.boxName = _userModelService.userModel.uuid;
    return _taskRepository.create(taskModel);
  }

  @override
  Future<List<TaskModel>> readAll() {
    TaskRepositoryImp.boxName = _userModelService.userModel.uuid;

    return _taskRepository.readAll();
  }

  @override
  Future<TaskModel?> readByUuid(String uuid) {
    TaskRepositoryImp.boxName = _userModelService.userModel.uuid;

    return _taskRepository.readByUuid(uuid);
  }

  @override
  Future<List<TaskModel>> readByPeriod(
      {required DateTime start, DateTime? end}) {
    TaskRepositoryImp.boxName = _userModelService.userModel.uuid;

    return _taskRepository.readByPeriod(start: start, end: end);
  }

  @override
  Future<void> update(TaskModel taskModel) {
    TaskRepositoryImp.boxName = _userModelService.userModel.uuid;

    return _taskRepository.update(taskModel);
  }

  @override
  Future<void> deleteAll() {
    TaskRepositoryImp.boxName = _userModelService.userModel.uuid;

    return _taskRepository.deleteAll();
  }

  @override
  Future<void> deleteByUuid(String uuid) {
    TaskRepositoryImp.boxName = _userModelService.userModel.uuid;

    return _taskRepository.deleteByUuid(uuid);
  }
}
