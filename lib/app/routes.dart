import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/auth/auth_dependencies.dart';
import 'package:todo05/app/presentation/controllers/auth/login/login_dependencies.dart';
import 'package:todo05/app/presentation/controllers/auth/method/email_password/email_password_dependencies.dart';
import 'package:todo05/app/presentation/controllers/home/home_dependencies.dart';
import 'package:todo05/app/presentation/controllers/task/append/task_append_dependencies.dart';
import 'package:todo05/app/presentation/controllers/user/additional_info/user_additional_info_dependencies.dart';
import 'package:todo05/app/presentation/controllers/user/edit/user_edit_dependencies.dart';
import 'package:todo05/app/presentation/pages/auth/login/login_page.dart';
import 'package:todo05/app/presentation/pages/auth/method/email_password/email_password_page.dart';
import 'package:todo05/app/presentation/pages/error/erro_page.dart';
import 'package:todo05/app/presentation/pages/home/home_page.dart';
import 'package:todo05/app/presentation/pages/splash/splash_page.dart';
import 'package:todo05/app/presentation/pages/task/append/task_append_page.dart';
import 'package:todo05/app/presentation/pages/user/additional_info/user_additional_info_page.dart';
import 'package:todo05/app/presentation/pages/user/analyzing_info/user_analyzing_info_page.dart';
import 'package:todo05/app/presentation/pages/user/edit/user_edit_page.dart';

class Routes {
  static const errorPage = '/erro';
  static const splash = '/';
  static const authLogin = '/auth/login';
  static const authEmailPassword = '/auth/email_password';
  static const userAdditionalInfo = '/user/additional_info';
  static const userAnalyzingInfo = '/user/analyzing_info';
  static const userEdit = '/user/edit';
  static const home = '/home';
  static const taskAppend = '/task/append';

  static final pageList = [
    GetPage(
      name: Routes.errorPage,
      page: () => ErroPage(),
    ),
    GetPage(
      name: Routes.splash,
      binding: AuthDependencies(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.authLogin,
      binding: AuthLoginDependencies(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.authEmailPassword,
      binding: AuthEmailPasswordDependencies(),
      page: () => AuthEmailPasswordPage(),
    ),
    GetPage(
      name: Routes.userAdditionalInfo,
      binding: UserAdditionalInfoDependencies(),
      page: () => UserAdditionalInfoPage(),
    ),
    GetPage(
      name: Routes.userAnalyzingInfo,
      page: () => UserAnalyzingInfoPage(),
    ),
    GetPage(
      name: Routes.userEdit,
      binding: UserEditDependencies(),
      page: () => UserEditPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeDependencies(),
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.taskAppend,
      binding: TaskAppendDependencies(),
      page: () => TaskAppendPage(),
    ),
  ];
}
