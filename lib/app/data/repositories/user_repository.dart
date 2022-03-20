import 'package:todo05/app/domain/models/user/user_model.dart';

abstract class UserRepository {
  Future<UserModel> create(Map<String, dynamic> data);
  Future<UserModel?> getByUidAuth(String uidAuth);
  Future<void> update(UserModel userModel);
  Future<UserModel?> getByUuid(String uuid);
}
