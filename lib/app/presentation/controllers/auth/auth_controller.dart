import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo05/app/domain/usecases/auth/auth_usecase.dart';
import 'package:todo05/app/presentation/routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth;
  final AuthUseCase _authService;
  AuthController({
    required FirebaseAuth firebaseAuth,
    required AuthUseCase authService,
  })  : _firebaseAuth = firebaseAuth,
        _authService = authService;

  Rx<User?> _userFirebaseAuth = Rx<User?>(FirebaseAuth.instance.currentUser);
  User? get user => _userFirebaseAuth.value;

  @override
  onInit() {
    _userFirebaseAuth.bindStream(_firebaseAuth.authStateChanges());
    _userFirebaseAuth.bindStream(_firebaseAuth.userChanges());
    ever<User?>(_userFirebaseAuth, (user) async {
      if (user != null) {
        print('userAdditionalInfo');
        Get.offAllNamed(Routes.userAdditionalInfo);
      } else {
        print('login');
        Get.offAllNamed(Routes.authLogin);
      }
    });
    super.onInit();
  }

  Future<void> logout() => _authService.logout();
}
