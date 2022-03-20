import 'package:get/get.dart';
import 'package:todo05/app/domain/models/user/user_model.dart';

class UserService extends GetxService {
  Rxn<UserModel> _userModel = Rxn<UserModel>();
  UserModel get userModel => _userModel.value!;
  set userModel(UserModel userModel) {
    _userModel(userModel);
  }
  // set userModel2(UserModel? userModel2) {
  //   _userModel2(userModel2);
  // }
  // Future<UserModelService> init() async {
  //   return this;
  // }
}
