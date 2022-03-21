import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/task/task_repository_firebase_impl.dart';
import 'package:todo05/app/data/datasources/hive/task/task_repository_impl.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase_impl.dart';
import 'package:todo05/app/domain/usecases/user/user_service.dart';
import 'package:todo05/app/presentation/controllers/home/home_controller.dart';

class HomeDependencies implements Bindings {
  @override
  void dependencies() {
    var userService = Get.find<UserService>();
    print('+++ HomeDependencies: ${userService.userModel.database}');
    Get.put<TaskRepository>(
      TaskRepositoryFirebaseImp(firebaseFirestore: Get.find()),
      tag: 'Firebase',
    );
    Get.put<TaskRepository>(
      TaskRepositoryHiveImp(),
      tag: 'Hive',
    );
    Get.put<TaskUseCase>(
      TaskUseCaseImp(
          taskRepository: Get.find(tag: (userService.userModel.database)),
          userService: Get.find()),
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