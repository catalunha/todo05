import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:todo05/app/model/models/task/task_model.dart';
import 'package:todo05/app/model/repositories/task/task_repository.dart';
import 'package:todo05/app/viewmodel/user/user_additional_info/usermodel_service.dart';

class TaskRepositoryImp implements TaskRepository {
  UserModelService _userModelService;
  TaskRepositoryImp({
    required UserModelService userModelService,
  }) : _userModelService = userModelService;

  // static const boxName = "task";
  String boxName() {
    print('boxName: ${_userModelService.userModel2!.uuid}');
    return _userModelService.userModel2!.uuid;
  }

  @override
  Future<void> create(TaskModel taskModel) async {
    var box = await Hive.openBox(boxName());
    await box.put(taskModel.uuid, taskModel.toJson());
    var taskJson = box.get(taskModel.uuid);
    var taskModel2 = taskJson == null ? null : TaskModel.fromJson(taskJson);
    if (taskModel2 != null) {}
    await box.close();
  }

  @override
  Future<List<TaskModel>> readAll() async {
    var box = await Hive.openBox(boxName());
    var taskList = box.values.map((e) => TaskModel.fromJson(e)).toList();
    await box.close();
    return taskList;
  }

  @override
  Future<TaskModel?> readByUuid(String uuid) async {
    var box = await Hive.openBox(boxName());
    var taskJson = box.get(uuid);
    var taskModel = taskJson == null ? null : TaskModel.fromJson(taskJson);
    await box.close();
    return taskJson;
  }

  @override
  Future<List<TaskModel>> readByPeriod(
      {required DateTime start, DateTime? end}) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    DateTime endFilter;
    if (end == null) {
      endFilter = DateTime(start.year, start.month, start.day, 23, 59, 59);
    } else {
      endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    }
    var box = await Hive.openBox(boxName());

    var taskList = box.values.map((e) => TaskModel.fromJson(e)).toList();
    var taskFiltered = <TaskModel>[];
    for (var task in taskList) {
      //print(task);
      if (task.date.isAtSameMomentAs(startFilter) ||
          task.date.isAtSameMomentAs(endFilter)) {
        taskFiltered.add(task);
      } else if (task.date.isAfter(startFilter) &&
          task.date.isBefore(endFilter)) {
        taskFiltered.add(task);
      }
      //print(taskFiltered);
    }
    await box.close();

    return taskFiltered;
  }

  @override
  Future<void> update(TaskModel taskModel) async {
    var box = await Hive.openBox(boxName());
    await box.put(taskModel.uuid, taskModel.toJson());
    await box.close();
  }

  @override
  Future<void> deleteAll() async {
    var box = await Hive.openBox(boxName());
    await box.deleteFromDisk();
    await box.close();
  }

  @override
  Future<void> deleteByUuid(String uuid) async {
    var box = await Hive.openBox(boxName());
    await box.delete(uuid);
    await box.close();
  }
}
