import 'package:get/get.dart';
import 'package:todo05/app/viewmodel/auth/login/login_controller.dart';

class AuthLoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
        () => LoginController(authService: Get.find()));
  }
}
