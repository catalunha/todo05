import 'package:todo05/app/domain/models/user/user_model.dart';

abstract class UserService {
  Future<UserModel> create(Map<String, dynamic> data);
  Future<UserModel?> getByUidAuth(String uidAuth);
}
