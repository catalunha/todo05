import 'package:get/get.dart';
import 'package:todo05/app/domain/services/databases_service.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase_impl.dart';
import 'package:todo05/app/presentation/controllers/home/home_controller.dart';

class HomeDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<DataBasesService>(
      DataBasesService(),
    );
    Get.put<TaskUseCase>(
      TaskUseCaseImp(dataBasesService: Get.find(), userService: Get.find()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskService: Get.find(),
        userService: Get.find(),
      ),
    );
  }
}


/*
class HomeDependencies implements Bindings {
  @override
  void dependencies() {
    var userService = Get.find<UserService>();
    print('+++ HomeDependencies: ${userService.userModel.database}');
    if (userService.userModel.database == 'firebase') {
      Get.put<TaskRepository>(
        TaskRepositoryFirebaseImp(firebaseFirestore: Get.find()),
      );
    } else {
      Get.put<TaskRepository>(
        TaskRepositoryImp(),
      );
    }
    Get.put<TaskUseCase>(
      TaskUseCaseImp(taskRepository: Get.find(), userService: Get.find()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskService: Get.find(),
        userService: Get.find(),
      ),
    );
  }
}

*/