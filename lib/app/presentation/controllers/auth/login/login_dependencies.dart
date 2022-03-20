import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/auth/login/login_controller.dart';

class AuthLoginDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
        () => LoginController(authService: Get.find()));
  }
}
