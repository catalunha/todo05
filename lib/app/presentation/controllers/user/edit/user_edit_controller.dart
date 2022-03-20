import 'package:get/get.dart';
import 'package:todo05/app/domain/models/user/user_model.dart';
import 'package:todo05/app/domain/usecases/user/user_service.dart';
import 'package:todo05/app/domain/usecases/user/user_usecase.dart';

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

  updateData({required String displayName, required String photoUrl}) async {
    var userModelUpdate =
        userModel!.copyWith(displayName: displayName, photoUrl: photoUrl);
    await _userUseCase.update(userModelUpdate);
    var controller = Get.find<UserService>();
    controller.userModel = userModelUpdate;
  }
}
