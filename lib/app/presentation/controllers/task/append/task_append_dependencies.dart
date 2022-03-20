import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/hive/task/task_repository_impl.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase_impl.dart';
import 'package:todo05/app/presentation/controllers/task/append/task_append_controller.dart';

class TaskAppendDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<TaskRepository>(
      TaskRepositoryImp(),
    );
    Get.put<TaskUseCase>(
      TaskUseCaseImp(taskRepository: Get.find(), userModelService: Get.find()),
    );
    Get.lazyPut<TaskAppendController>(
        () => TaskAppendController(taskUseCase: Get.find()));
  }
}
