import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo05/app/domain/models/task/task_model.dart';
import 'package:todo05/app/domain/usecases/user/user_service.dart';

class TaskController extends GetxController {
  UserService _userService;
  TaskController({required UserService userService})
      : _userService = userService;
  Box<TaskModel>? _boxTask;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _boxTask = await openBoxTask();
  }

  Stream<List<TaskModel>> bindHive() {
    return _boxTask!.watch().map((event) => _boxTask!.values.toList());
  }

  Future<List<TaskModel>> firstData() async => _boxTask!.values.toList();
  Future<Box<TaskModel>> openBoxTask() async {
    // if (Hive.box<TaskModel>(_userService.userModel.uuid).i) {
    //   return Get.find<Box<TaskModel>>();
    // } else {
    print('+++ TaskController 1: ${_userService.userModel.database}');
    Hive.registerAdapter(TaskModelAdapter());
    // Box<TaskModel> _boxTask = await openBoxTask();
    _boxTask = await Hive.openBox<TaskModel>(_userService.userModel.uuid);

    Get.put<Box<TaskModel>>(
      _boxTask!,
      permanent: true,
    );
    return await Hive.openBox<TaskModel>(_userService.userModel.uuid);
    // }
  }
}
