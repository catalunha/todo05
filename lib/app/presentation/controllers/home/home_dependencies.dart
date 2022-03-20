import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/hive/task/task_repository_impl.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase_impl.dart';
import 'package:todo05/app/presentation/controllers/home/home_controller.dart';
import 'package:todo05/app/presentation/controllers/task/hive_controller.dart';

class HomeDependencies implements Bindings {
  @override
  void dependencies() async {
    // Get.put<TaskController>(
    //   TaskController(userService: Get.find()),
    // );
    Get.put<TaskRepository>(
      TaskRepositoryImp(),
    );
    Get.put<TaskUseCase>(
      TaskUseCaseImp(taskRepository: Get.find(), userModelService: Get.find()),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        taskService: Get.find(),
        userService: Get.find(),
      ),
    );
  }
}
