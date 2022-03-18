import 'package:get/get.dart';
import 'package:todo05/app/model/models/task/task_model.dart';
import 'package:todo05/app/model/repositories/task/task_repository_exception.dart';
import 'package:todo05/app/viewmodel/home/home_controller.dart';
import 'package:todo05/app/viewmodel/services/task/task_service.dart';
import 'package:todo05/app/viewmodel/utils/mixins/loader_mixin.dart';
import 'package:todo05/app/viewmodel/utils/mixins/message_mixin.dart';
import 'package:uuid/uuid.dart';

class TaskAppendController extends GetxController
    with LoaderMixin, MessageMixin {
  TaskService _taskService;
  TaskAppendController({required TaskService taskService})
      : _taskService = taskService;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _taskModel = Rxn<TaskModel>();
  TaskModel? get taskModel => _taskModel.value;

  var _selectedDate = DateTime.now().obs;
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? selectedDate) {
    if (selectedDate != null) {
      _selectedDate.value = selectedDate;
    } else {
      _selectedDate.value = DateTime.now();
    }
  }

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
    TaskModel? model = Get.arguments;
    print('model: $model');
    if (model != null) {
      selectedDate = model.date;
    }
    _taskModel(model);
    print('_taskModel: ${_taskModel.value == null}');
  }

  Future<void> create(String description) async {
    try {
      _loading(true);
      DateTime date =
          DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day);
      if (_taskModel.value == null) {
        var taskModel = TaskModel(
            uuid: const Uuid().v4(),
            description: description,
            date: date,
            itsDone: false,
            itsDoing: false);
        print('create 0: ${taskModel.toString()}');
        print('create 0: ${taskModel.toMap()}');
        print('create 0: ${taskModel.toJson()}');

        await _taskService.create(taskModel);
      } else {
        var taskModel =
            _taskModel.value!.copyWith(date: date, description: description);
        await _taskService.update(taskModel);
      }
      final HomeController _homeController = Get.find();
      await _homeController.loadTasks(date);
      await _homeController.tasksByDay();
    } on TaskRepositoryException catch (e) {
      _message.value = MessageModel(
        title: 'Erro em Repository',
        message: 'Nao foi possivel salvar a tarefa',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
