// import 'package:get/get.dart';
// import 'package:todo05/app/data/datasources/firebase/task/task_repository_firebase_impl.dart';
// import 'package:todo05/app/data/datasources/hive/task/task_repository_hive_impl.dart';

// class DataBasesService extends GetxService {
//   TaskRepositoryHiveImp get hive => TaskRepositoryHiveImp.instance;
//   TaskRepositoryFirebaseImp get firebase => TaskRepositoryFirebaseImp.instance;

//   var _dataBaseInstance;
//   T dataBaseInstance<T>() {
//     return _dataBaseInstance as T;
//   }

//   T dataBaseConfig<T>(Map<String, dynamic> databaseInfo) {
//     if (databaseInfo['dataBaseType'] == 'Firebase') {
//       firebase.userUuid = databaseInfo['userUuid'];
//       firebase.firebaseFirestore = Get.find();

//       _dataBaseInstance = firebase as T;
//       return firebase as T;
//     } else {
//       hive.userUuid = databaseInfo['userUuid'];

//       _dataBaseInstance = hive as T;
//       return hive as T;
//     }
//   }
// }
