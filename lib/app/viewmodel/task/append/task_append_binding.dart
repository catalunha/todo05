import 'package:get/get.dart';
import 'package:todo05/app/model/repositories/task/task_repository.dart';
import 'package:todo05/app/model/repositories/task/task_repository_impl.dart';
import 'package:todo05/app/viewmodel/services/task/task_service.dart';
import 'package:todo05/app/viewmodel/services/task/task_service_impl.dart';
import 'package:todo05/app/viewmodel/task/append/task_append_controller.dart';

class TaskAppendBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TaskRepository>(
      TaskRepositoryImp(userModelService: Get.find()),
    );
    Get.put<TaskService>(
      TaskServiceImp(taskRepository: Get.find()),
    );
    Get.lazyPut<TaskAppendController>(
        () => TaskAppendController(taskService: Get.find()));
  }
}
