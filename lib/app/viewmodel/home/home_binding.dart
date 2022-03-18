import 'package:get/get.dart';
import 'package:todo05/app/model/hive/hive_connection_factory.dart';
import 'package:todo05/app/model/repositories/task/task_repository.dart';
import 'package:todo05/app/model/repositories/task/task_repository_impl.dart';
import 'package:todo05/app/viewmodel/home/home_controller.dart';
import 'package:todo05/app/viewmodel/services/task/task_service.dart';
import 'package:todo05/app/viewmodel/services/task/task_service_impl.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TaskRepository>(
      TaskRepositoryImp(userController: Get.find()),
    );
    Get.put<TaskService>(
      TaskServiceImp(taskRepository: Get.find()),
    );

    Get.lazyPut<HomeController>(() => HomeController(taskService: Get.find()));
  }
}
