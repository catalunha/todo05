import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/auth/auth_repository_impl.dart';
import 'package:todo05/app/data/repositories/auth_repository.dart';
import 'package:todo05/app/domain/usecases/auth/auth_usecase.dart';
import 'package:todo05/app/domain/usecases/auth/auth_usecase_impl.dart';
import 'package:todo05/app/presentation/controllers/auth/auth_controller.dart';

class AuthDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuth>(
      FirebaseAuth.instance,
      permanent: true,
    );
    Get.put<FirebaseFirestore>(
      FirebaseFirestore.instance,
      permanent: true,
    );
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        firebaseAuth: Get.find(),
      ),
      permanent: true,
    );
    Get.put<AuthUseCase>(
      AuthUseCaseImpl(
        authRepository: Get.find(),
      ),
      permanent: true,
    );

    Get.put<AuthController>(
      AuthController(
        firebaseAuth: Get.find(),
        authService: Get.find(),
      ),
      permanent: true,
    );
  }
}
