import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/user/user_repository_impl.dart';
import 'package:todo05/app/data/repositories/user_repository.dart';
import 'package:todo05/app/domain/usecases/user/user_usecase.dart';
import 'package:todo05/app/domain/usecases/user/user_usecase_impl.dart';
import 'package:todo05/app/domain/services/user_service.dart';
import 'package:todo05/app/presentation/controllers/user/additional_info/user_additional_info_controller.dart';

class UserAdditionalInfoDependencies implements Bindings {
  @override
  void dependencies() async {
    Get.put<UserRepository>(
      UserRepositoryImpl(
        firebaseFirestore: Get.find(),
      ),
    );
    Get.put<UserUseCase>(
      UserUseCaseImpl(
        userRepository: Get.find(),
      ),
    );
    Get.put<UserService>(
      UserService(),
    );
    Get.lazyPut(
      () => UserAdditionalInfoController(
        authController: Get.find(),
        userService: Get.find(),
      ),
    );
  }
}
