import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/user/user_repository_impl.dart';
import 'package:todo05/app/data/repositories/user_repository.dart';
import 'package:todo05/app/domain/usecases/user/user_service.dart';
import 'package:todo05/app/domain/usecases/user/user_service_impl.dart';
import 'package:todo05/app/presentation/controllers/user/user_additional_info/user_additional_info_controller.dart';
import 'package:todo05/app/presentation/controllers/user/user_additional_info/usermodel_service.dart';

class UserAdditionalInfoBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put<UserRepository>(
      UserRepositoryImpl(
        firebaseFirestore: Get.find(),
      ),
    );
    Get.put<UserService>(
      UserServiceImpl(
        userRepository: Get.find(),
      ),
    );
    Get.put<UserModelService>(
      UserModelService(),
    );
    Get.lazyPut(
      () => UserAdditionalInfoController(
        authController: Get.find(),
        userService: Get.find(),
      ),
    );
  }
}
