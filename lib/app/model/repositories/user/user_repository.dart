import 'package:todo05/app/model/models/user/user_model.dart';

abstract class UserRepository {
  Future<UserModel> create(Map<String, dynamic> data);
  Future<void> update(Map<String, dynamic> data);
  Future<UserModel?> getByUidAuth(String uidAuth);
  Future<UserModel?> getByUuid(String uuid);
}
