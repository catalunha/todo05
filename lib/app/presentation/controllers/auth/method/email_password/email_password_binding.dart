import 'package:get/get.dart';
import 'package:todo05/app/viewmodel/auth/method/email_password/email_password_controller.dart';

class AuthEmailPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailPasswordController>(
        () => EmailPasswordController(authService: Get.find()));
  }
}
