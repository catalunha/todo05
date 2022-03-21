import 'package:get/get.dart';
import 'package:todo05/app/domain/services/databases_service.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase.dart';
import 'package:todo05/app/domain/usecases/task/task_usecase_impl.dart';
import 'package:todo05/app/presentation/controllers/task/append/task_append_controller.dart';

class TaskAppendDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<DataBasesService>(
      DataBasesService(),
    );
    Get.put<TaskUseCase>(
      TaskUseCaseImp(dataBasesService: Get.find(), userService: Get.find()),
    );
    Get.lazyPut<TaskAppendController>(
        () => TaskAppendController(taskUseCase: Get.find()));
  }
}
