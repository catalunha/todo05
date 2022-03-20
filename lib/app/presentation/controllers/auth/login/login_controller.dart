import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/auth/auth_repository_exception.dart';
import 'package:todo05/app/domain/usecases/auth/auth_usecase.dart';
import 'package:todo05/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:todo05/app/presentation/controllers/utils/mixins/message_mixin.dart';

class LoginController extends GetxController with LoaderMixin, MessageMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final AuthUseCase _authService;
  LoginController({required AuthUseCase authService})
      : _authService = authService;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  Future<void> loginGoogle() async {
    try {
      _loading(true);
      final user = await _authService.loginGoogle();
      if (user != null) {
        //success
      } else {
        _authService.logout();
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Em escolher conta do Google',
          isError: true,
        );
      }
    } on AuthRepositoryException catch (e) {
      _authService.logout();
      _message.value = MessageModel(
        title: 'AuthRepositoryException',
        message: 'Em escolher conta do Google',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  Future<void> loginEmail(String email, String password) async {
    try {
      _loading(true);
      final user =
          await _authService.loginEmail(email: email, password: password);
      if (user != null) {
        //success
      } else {
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Usuário ou senha inválidos.',
          isError: true,
        );
      }
    } on AuthRepositoryException catch (e) {
      _loading(false);
      _message.value = MessageModel(
        title: 'Oops',
        message: e.message,
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final user = await _authService.forgotPassword(email);
      _message.value = MessageModel(
        title: 'Erro',
        message: 'orientações sobre recuperação de senha ',
      );
    } on AuthRepositoryException catch (e) {
      _authService.logout();
      _message.value = MessageModel(
        title: 'AuthRepositoryException',
        message: 'Em recuperar senha',
        isError: true,
      );
    }
  }
}
