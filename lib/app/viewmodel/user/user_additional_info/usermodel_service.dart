import 'package:get/get.dart';
import 'package:todo05/app/model/models/user/user_model.dart';

class UserModelService extends GetxService {
  Rxn<UserModel> _userModel2 = Rxn<UserModel>();
  UserModel? get userModel2 => _userModel2.value;
  set userModel2(UserModel? userModel2) {
    _userModel2(userModel2);
  }
  // Future<UserModelService> init() async {
  //   return this;
  // }
}
