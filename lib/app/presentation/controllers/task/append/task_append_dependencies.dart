import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/task/task_repository_factory_firebase.dart';
import 'package:todo05/app/data/datasources/hive/task/task_repository_factory_hive.dart';
import 'package:todo05/app/data/repositories/factories/task_repository_factory.dart';
import 'package:todo05/app/domain/services/databases_service.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase_impl.dart';
import 'package:todo05/app/presentation/controllers/task/append/task_append_controller.dart';

class TaskAppendDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<TaskUseCase>(
      TaskUseCaseImp(
          taskRepositoryFactory: Get.find(), userService: Get.find()),
    );
    Get.lazyPut<TaskAppendController>(
        () => TaskAppendController(taskUseCase: Get.find()));
  }
}
