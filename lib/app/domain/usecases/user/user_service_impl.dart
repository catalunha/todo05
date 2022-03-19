import 'package:todo05/app/model/models/user/user_model.dart';
import 'package:todo05/app/model/repositories/user/user_repository.dart';
import 'package:todo05/app/viewmodel/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<UserModel?> getByUidAuth(String uidAuth) async {
    print('Em UserRepositoryImpl.getByuid');
    return await _userRepository.getByUidAuth(uidAuth);
  }

  @override
  Future<UserModel> create(Map<String, dynamic> data) async {
    print('Em UserRepositoryImpl.create');
    return await _userRepository.create(data);
  }
}
