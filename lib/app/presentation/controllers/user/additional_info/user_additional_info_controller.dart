import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo05/app/data/datasources/firebase/user/user_repository_exception.dart';
import 'package:todo05/app/domain/models/user/user_model.dart';
import 'package:todo05/app/domain/usecases/user/user_usecase.dart';
import 'package:todo05/app/presentation/controllers/auth/auth_controller.dart';
import 'package:todo05/app/domain/usecases/user/user_service.dart';
import 'package:todo05/app/presentation/controllers/utils/mixins/loader_mixin.dart';
import 'package:todo05/app/presentation/controllers/utils/mixins/message_mixin.dart';
import 'package:todo05/app/routes.dart';

class UserAdditionalInfoController extends GetxController
    with LoaderMixin, MessageMixin {
  final AuthController _authController;
  final UserUseCase _userService;
  UserAdditionalInfoController({
    required AuthController authController,
    required UserUseCase userService,
  })  : _authController = authController,
        _userService = userService;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  User? get userAuth => _authController.user;

  UserModel? _userModel;
  // Rxn<UserModel> _userModel = Rxn<UserModel>();
  // UserModel? get userModel => _userModel.value;

  var getAdditionalInformation = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
    await getUser();
  }

  Future<void> getUser() async {
    try {
      print('UserController');
      print('userUid: ${userAuth!.uid}');
      var userTemp = await _userService.getByUidAuth(userAuth!.uid);
      // _userModel(userTemp);
      if (userTemp == null) {
        // if (_userModel.value == null) {
        if (getAdditionalInformation.isTrue) {
          print('Usuario não cadastrado. E tem informações complementares.');
          getAdditionalInformation(true);
        } else {
          print('Usuario não cadastrado. Não tem informações complementares.');
          await userCreate();
          goToHomeOrAnalisyng();
        }
      } else {
        _userModel = UserModel.fromMap(userTemp.toMap());
        print('Usuario cadastrado.');
        goToHomeOrAnalisyng();
      }
    } on UserRepositoryException catch (e) {
      print('Erro em user exception');
      print(e.message);
      _message.value = MessageModel(
        title: 'Erro de UserRepositoryException em UserController.getUser',
        message: e.message,
        isError: true,
      );
      Get.offAllNamed(Routes.errorPage, arguments: e.message);
    } catch (e) {
      print('Erro geral em _userService.getByuid(${userAuth!.uid})');
      print(e);
      _message.value = MessageModel(
        title: 'Erro geral em UserController.getUser',
        message: "$e",
        isError: true,
      );
      Get.offAllNamed(Routes.errorPage, arguments: '$e');
    }
  }

  void setAdditionalInformation({
    required bool doing,
  }) async {
    getAdditionalInformation(false);

    Map<String, dynamic> data = {};
    //Dados coletados na page
    data['doing'] = doing;
    print(data);
    await userCreate(data: data);
    goToHomeOrAnalisyng();
  }

  void goToHomeOrAnalisyng() {
    if (_userModel!.inAnalysis) {
      print('indo para userAnalyzingInfo');
      Get.offAllNamed(Routes.userAnalyzingInfo);
    } else {
      var controller = Get.find<UserService>();
      controller.userModel = UserModel.fromMap(_userModel!.toMap());
      print('indo para home');
      Get.offAllNamed(Routes.home);
    }
  }

  Map<String, dynamic> userFieldsBasics() {
    Map<String, dynamic> data = {};
    //Dados basicos do userModel - internos
    data['createdAt'] = DateTime.now();
    data['inAnalysis'] = true;
    return data;
  }

  Future<UserModel> userCreate({Map<String, dynamic>? data}) async {
    data ??= <String, dynamic>{};
    print("Usuario nao encontrado. Criando..");
    data.addAll(userFieldsBasics());
    data['uidAuth'] = userAuth?.uid;
    data['email'] = userAuth?.email;
    data['displayName'] = userAuth?.displayName;
    data['photoUrl'] = userAuth?.photoURL;
    print(data);

    try {
      var userTemp = await _userService.create(data);
      _userModel = UserModel.fromMap(userTemp.toMap());
      // _userModel(userTemp);
      // return _userModel.value!;
      return userTemp;
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro',
        message: 'Nao consegui criar UserModel',
        isError: true,
      );
      rethrow;
    }
  }

  void includeDoing(bool? value) {}
}
