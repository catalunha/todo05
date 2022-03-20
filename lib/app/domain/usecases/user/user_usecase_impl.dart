import 'package:todo05/app/data/repositories/user_repository.dart';
import 'package:todo05/app/domain/models/user/user_model.dart';
import 'package:todo05/app/domain/usecases/user/user_usecase.dart';

class UserUseCaseImpl implements UserUseCase {
  final UserRepository _userRepository;
  UserUseCaseImpl({required UserRepository userRepository})
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

  @override
  Future<void> update(UserModel userModel) async {
    await _userRepository.update(userModel);
  }
}
