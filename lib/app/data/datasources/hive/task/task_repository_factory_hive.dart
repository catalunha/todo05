import 'package:todo05/app/data/datasources/hive/task/task_repository_hive_impl.dart';
import 'package:todo05/app/data/repositories/factories/task_repository_factory.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/services/user_service.dart';

class TaskRepositoryFactoryHive implements TaskRepositoryFactory {
  UserService _userService;

  TaskRepositoryFactoryHive({
    required UserService userService,
  }) : _userService = userService;

  @override
  TaskRepository produce() {
    TaskRepositoryHiveImp taskRepositoryHiveImp =
        TaskRepositoryHiveImp.instance;
    taskRepositoryHiveImp.userUuid = _userService.userModel.uuid;
    return taskRepositoryHiveImp;
  }
}
