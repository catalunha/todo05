import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/task/task_repository_firebase_impl.dart';
import 'package:todo05/app/data/datasources/hive/task/task_repository_hive_impl.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/models/task/task_model.dart';
import 'package:todo05/app/domain/services/databases_service.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase.dart';
import 'package:todo05/app/domain/services/user_service.dart';

class TaskUseCaseImp implements TaskUseCase {
  DataBasesService _dataBasesService;
  UserService _userService;

  TaskUseCaseImp({
    required DataBasesService dataBasesService,
    required UserService userService,
  })  : _dataBasesService = dataBasesService,
        _userService = userService {
    dataBaseConfig();
  }
  var _database;
  void dataBaseConfig() {
    var userService = Get.find<UserService>();
    var map = {
      'dataBaseType': userService.userModel.database,
      'userUuid': userService.userModel.uuid,
    };
    _dataBasesService.dataBaseConfig(map);
    _database = _dataBasesService.dataBaseInstance();
  }

  @override
  Future<void> create(TaskModel taskModel) {
    return _database.create(taskModel);
  }

  @override
  Future<List<TaskModel>> readAll() {
    return _database.readAll();
  }

  @override
  Future<TaskModel?> readByUuid(String uuid) {
    return _database.readByUuid(uuid);
  }

  @override
  Future<List<TaskModel>> readByPeriod(
      {required DateTime start, DateTime? end}) {
    return _database.readByPeriod(start: start, end: end);
  }

  @override
  Future<void> update(TaskModel taskModel) {
    return _database.update(taskModel);
  }

  @override
  Future<void> deleteAll() {
    return _database.deleteAll();
  }

  @override
  Future<void> deleteByUuid(String uuid) {
    return _database.deleteByUuid(uuid);
  }
}
