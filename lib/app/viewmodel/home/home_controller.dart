import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo05/app/model/models/task/task_day_model.dart';
import 'package:todo05/app/model/models/task/task_model.dart';
import 'package:todo05/app/model/repositories/task/task_repository_exception.dart';
import 'package:todo05/app/routes.dart';
import 'package:todo05/app/viewmodel/services/task/task_service.dart';
import 'package:todo05/app/viewmodel/services/task/task_service_exception.dart';
import 'package:todo05/app/viewmodel/utils/mixins/loader_mixin.dart';
import 'package:todo05/app/viewmodel/utils/mixins/message_mixin.dart';

class HomeController extends GetxController with LoaderMixin, MessageMixin {
  final TaskService _taskService;
  HomeController({required TaskService taskService})
      : _taskService = taskService;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  var allTasks = <TaskModel>[].obs;

  var tasksDay = <TasksDayModel>[].obs;

  var groupDate = ''.obs;
  final dateFormat = DateFormat('y-MM-dd');

  @override
  void onInit() async {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
    await rescheduleTask();
    await loadTasks(DateTime.now());
    await tasksByDay();
  }

  Future<void> rescheduleTask() async {
    List<TaskModel> _list = await _taskService.readAll();
    var now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1, 23, 59, 0);
    for (var item in _list) {
      if (item.date.isBefore(yesterday)) {
        _taskService.update(item.copyWith(date: now));
      }
    }
  }

  Future<void> tasksByDay() async {
    List<TaskModel> _allTasks = await _taskService.readAll();
    Map<String, TasksDayModel> _tasksByDay = {};
    for (var item in _allTasks) {
      _tasksByDay.update(
        dateFormat.format(item.date),
        (value) => value = item.itsDone
            ? value.copyWith(quantityDone: value.quantityDone + 1)
            : value.copyWith(quantityNotDone: value.quantityNotDone + 1),
        ifAbsent: () => TasksDayModel(
          dateTime: item.date,
          quantityDone: item.itsDone ? 1 : 0,
          quantityNotDone: item.itsDone ? 0 : 1,
        ),
      );
    }

    List<TasksDayModel> _tasksDay = [];
    for (var item in _tasksByDay.entries) {
      _tasksDay.add(item.value);
    }
    _tasksDay.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    tasksDay(_tasksDay);
  }

  Future<void> loadTasks(DateTime date) async {
    groupDate.value = dateFormat.format(date);

    try {
      List<TaskModel> _list = await _taskService.readByPeriod(start: date);
      // List<TaskModel> _list2 = await _taskService.readAll();
      // print('::: loadTasks - 2a (${_list2.length})');
      List<TaskModel> _itsDone =
          _list.where((task) => task.itsDone == true).toList();
      List<TaskModel> _notItsDone =
          _list.where((task) => task.itsDone == false).toList();
      allTasks([..._notItsDone, ..._itsDone]);
    } on TaskServiceException catch (e) {
      _message.value = MessageModel(
        title: 'Erro em Service',
        message: 'Nao consigo encontrar tasks',
        isError: true,
      );
    } on TaskRepositoryException catch (e) {
      _message.value = MessageModel(
        title: 'Erro em Respository',
        message: 'Nao consigo encontrar tasks',
        isError: true,
      );
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro desconhecido',
        message: 'Nao consigo encontrar tasks',
        isError: true,
      );
    }
  }

  Future<void> toggleDoneTask(TaskModel task) async {
    final taskUpdated = task.copyWith(itsDone: !task.itsDone);
    await _taskService.update(taskUpdated);
    await loadTasks(taskUpdated.date);
    await tasksByDay();
  }

  void addTask() {
    Get.toNamed(Routes.taskAppend, arguments: null);
  }

  void editTask(String id) {
    var _taskModel = allTasks.firstWhere((element) => element.uuid == id);

    Get.toNamed(Routes.taskAppend, arguments: _taskModel);
  }
}
