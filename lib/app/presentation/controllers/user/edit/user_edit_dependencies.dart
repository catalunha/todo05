import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/user/user_repository_impl.dart';
import 'package:todo05/app/data/repositories/user_repository.dart';
import 'package:todo05/app/domain/usecases/user/user_usecase.dart';
import 'package:todo05/app/domain/usecases/user/user_usecase_impl.dart';
import 'package:todo05/app/presentation/controllers/user/edit/user_edit_controller.dart';

class UserEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<UserRepository>(
      UserRepositoryImpl(firebaseFirestore: Get.find()),
    );
    Get.put<UserUseCase>(
      UserUseCaseImpl(userRepository: Get.find()),
    );
    Get.lazyPut<UserEditController>(
      () => UserEditController(
        userUseCase: Get.find(),
        userModelService: Get.find(),
      ),
    );
  }
}
