import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/datasources.dart';
import 'package:todo05/app/domain/models/user/user_model.dart';
import 'package:todo05/app/domain/services/user_service.dart';
import 'package:todo05/app/domain/usecases/user/user_usecase.dart';
import 'package:todo05/app/presentation/controllers/auth/auth_controller.dart';

class UserEditController extends GetxController {
  UserUseCase _userUseCase;
  UserService _userModelService;
  UserEditController({
    required UserUseCase userUseCase,
    required UserService userModelService,
  })  : _userUseCase = userUseCase,
        _userModelService = userModelService;
  final _userModel = Rxn<UserModel>();
  UserModel? get userModel => _userModel.value;
  @override
  void onInit() {
    super.onInit();
    _userModel(_userModelService.userModel);
  }

  updateData({
    required String displayName,
    required String photoUrl,
    required DatasourcesEnum database,
  }) async {
    var userModelUpdate = userModel!.copyWith(
        displayName: displayName, photoUrl: photoUrl, database: database);
    await _userUseCase.update(userModelUpdate);
    var controller = Get.find<UserService>();
    var databaseLast = controller.userModel.database;
    controller.userModel = userModelUpdate;
    if (databaseLast != database) {
      AuthController _authController = Get.find();
      _authController.logout();
    }
  }
}
