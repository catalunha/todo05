import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo05/app/data/datasources/hive/task/task_repository_exception.dart';
import 'package:todo05/app/data/repositories/task_repository.dart';
import 'package:todo05/app/domain/models/task/task_model.dart';
import 'package:todo05/app/domain/models/user/user_model.dart';

class TaskRepositoryFirebaseImp implements TaskRepository {
  // final FirebaseFirestore _firebaseFirestore;
  // final String _userUuid;

  // TaskRepositoryFirebaseImp(
  //     {required FirebaseFirestore firebaseFirestore, required String userUuid})
  //     : _firebaseFirestore = firebaseFirestore,
  //       _userUuid = userUuid;

  static TaskRepositoryFirebaseImp? _instance;

  TaskRepositoryFirebaseImp._();
  static TaskRepositoryFirebaseImp get instance {
    _instance ??= TaskRepositoryFirebaseImp._();
    return _instance!;
  }

  String _userUuid = '';
  set userUuid(String uuid) {
    _userUuid = uuid;
  }

  FirebaseFirestore? _firebaseFirestore;
  set firebaseFirestore(FirebaseFirestore firebaseFirestore) {
    _firebaseFirestore = firebaseFirestore;
  }

  @override
  Future<void> create(TaskModel taskModel) async {
    print('create firebase');
    try {
      CollectionReference docRef = _firebaseFirestore!
          .collection(UserModel.collection)
          .doc(_userUuid)
          .collection(TaskModel.collection);
      // String idNew = docRef.doc().id;
      // var taskModel2 = taskModel.copyWith(uuid: idNew);
      // print('create.map ${taskModel2.toMap()}');

      await docRef.doc(taskModel.uuid).set(taskModel.toMap());
    } catch (e) {
      throw TaskRepositoryException(
          message: 'Erro em TaskRepositoryImp.create');
    }
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteByUuid
    throw UnimplementedError();
  }

  @override
  Future<void> deleteByUuid(String uuid) async {
    await _firebaseFirestore!
        .collection(UserModel.collection)
        .doc(_userUuid)
        .collection(TaskModel.collection)
        .doc(uuid)
        .delete();
  }

  @override
  Future<List<TaskModel>> readAll() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore!
            .collection(UserModel.collection)
            .doc(_userUuid)
            .collection(TaskModel.collection)
            .get();
    List<TaskModel> listModel = <TaskModel>[];
    listModel = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => TaskModel.fromMap(
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    return listModel;
  }

  @override
  Future<List<TaskModel>> readByPeriod(
      {required DateTime start, DateTime? end}) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    DateTime endFilter;
    if (end == null) {
      endFilter = DateTime(start.year, start.month, start.day, 23, 59, 59);
    } else {
      endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    }
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore!
            .collection(UserModel.collection)
            .doc(_userUuid)
            .collection(TaskModel.collection)
            .where('date', isGreaterThanOrEqualTo: startFilter)
            .where('date', isLessThanOrEqualTo: endFilter)
            .get();
    List<TaskModel> listModel = <TaskModel>[];
    listModel = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => TaskModel.fromMap(
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    return listModel;
  }

  @override
  Future<TaskModel?> readByUuid(String uuid) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await _firebaseFirestore!
        .collection(UserModel.collection)
        .doc(_userUuid)
        .collection(TaskModel.collection)
        .doc(uuid)
        .get();
    var a = TaskModel.fromMap(doc.data()!);
    return a;
  }

  @override
  Future<void> update(TaskModel taskModel) async {
    try {
      CollectionReference docRef = _firebaseFirestore!
          .collection(UserModel.collection)
          .doc(_userUuid)
          .collection(TaskModel.collection);
      await docRef.doc(taskModel.uuid).update(taskModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
