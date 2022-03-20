import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/auth/auth_repository_exception.dart';
import 'package:todo05/app/domain/usecases/auth/auth_usecase.dart';
import 'package:todo05/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:todo05/app/presentation/controllers/utils/mixins/message_mixin.dart';

class EmailPasswordController extends GetxController
    with LoaderMixin, MessageMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final AuthUseCase _authService;
  EmailPasswordController({required AuthUseCase authService})
      : _authService = authService;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authService.register(
        email: email,
        password: password,
      );
      _loading(true);
      if (user != null) {
        //success
      } else {
        _authService.logout();
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Em registrar usuário',
          isError: true,
        );
      }
    } on AuthRepositoryException catch (e) {
      _authService.logout();
      _message.value = MessageModel(
        title: 'AuthRepositoryException',
        message: 'Em registrar usuário',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
