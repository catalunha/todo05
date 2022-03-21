import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo05/app/data/datasources/firebase/task/task_repository_firebase_impl.dart';
import 'package:todo05/app/data/repositories/factories/task_repository_factory.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/services/user_service.dart';

class TaskRepositoryFactoryFirebaseImpl implements TaskRepositoryFactory {
  final UserService _userService;
  final FirebaseFirestore _firebaseFirestore;

  TaskRepositoryFactoryFirebaseImpl({
    required UserService userService,
    required FirebaseFirestore firebaseFirestore,
  })  : _userService = userService,
        _firebaseFirestore = firebaseFirestore;

  @override
  TaskRepository produce() {
    TaskRepositoryFirebaseImp taskRepositoryHiveImp =
        TaskRepositoryFirebaseImp.instance;
    taskRepositoryHiveImp.userUuid = _userService.userModel.uuid;
    taskRepositoryHiveImp.firebaseFirestore = _firebaseFirestore;
    return taskRepositoryHiveImp;
  }
}
