import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/auth/auth_binding.dart';
import 'package:todo05/app/presentation/controllers/auth/login/login_binding.dart';
import 'package:todo05/app/presentation/controllers/auth/method/email_password/email_password_binding.dart';
import 'package:todo05/app/presentation/controllers/home/home_binding.dart';
import 'package:todo05/app/presentation/controllers/task/append/task_append_binding.dart';
import 'package:todo05/app/presentation/controllers/user/user_additional_info/user_additional_info_binding.dart';
import 'package:todo05/app/presentation/pages/auth/login/login_page.dart';
import 'package:todo05/app/presentation/pages/auth/method/email_password/email_password_page.dart';
import 'package:todo05/app/presentation/pages/error/erro_page.dart';
import 'package:todo05/app/presentation/pages/home/home_page.dart';
import 'package:todo05/app/presentation/pages/splash/splash_page.dart';
import 'package:todo05/app/presentation/pages/task/append/task_append_page.dart';
import 'package:todo05/app/presentation/pages/user/user_additional_info/user_additional_info_page.dart';
import 'package:todo05/app/presentation/pages/user/user_analyzing_info/user_analyzing_info_page.dart';

class Routes {
  static const errorPage = '/erro';
  static const splash = '/';
  static const authLogin = '/auth/login';
  static const authEmailPassword = '/auth/email_password';
  static const userAdditionalInfo = '/user/additional_info';
  static const userAnalyzingInfo = '/user/analyzing_info';
  static const home = '/home';
  static const taskAppend = '/task/append';

  static final pageList = [
    GetPage(
      name: Routes.errorPage,
      page: () => ErroPage(),
    ),
    GetPage(
      name: Routes.splash,
      binding: AuthBinding(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.authLogin,
      binding: AuthLoginBinding(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.authEmailPassword,
      binding: AuthEmailPasswordBinding(),
      page: () => AuthEmailPasswordPage(),
    ),
    GetPage(
      name: Routes.userAdditionalInfo,
      binding: UserAdditionalInfoBinding(),
      page: () => UserAdditionalInfoPage(),
    ),
    GetPage(
      name: Routes.userAnalyzingInfo,
      page: () => UserAnalyzingInfoPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeBinding(),
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.taskAppend,
      binding: TaskAppendBinding(),
      page: () => TaskAppendPage(),
    ),
  ];
}
