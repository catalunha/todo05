import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/auth/method/email_password/email_password_controller.dart';

class AuthEmailPasswordDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailPasswordController>(
        () => EmailPasswordController(authService: Get.find()));
  }
}
