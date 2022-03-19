import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/hive/task/task_repository_impl.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/usecases/task/task_service.dart';
import 'package:todo05/app/domain/usecases/task/task_service_impl.dart';
import 'package:todo05/app/presentation/controllers/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TaskRepository>(
      TaskRepositoryImp(),
    );
    Get.put<TaskService>(
      TaskServiceImp(taskRepository: Get.find(), userModelService: Get.find()),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        taskService: Get.find(),
        userModelService: Get.find(),
      ),
    );
  }
}
