import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/auth/auth_controller.dart';
import 'package:todo05/app/presentation/controllers/home/home_controller.dart';
import 'package:todo05/app/presentation/routes.dart';

class PopMenuButtonPhotoUser extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final AuthController _authController = Get.find();
  final UserDisplayNameVN = ValueNotifier<String>('');
  final UserPhotoUrlVN = ValueNotifier<String>('');

  PopMenuButtonPhotoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset.fromDirection(120.0, 100.0),
      child: Tooltip(
        message: 'Click para opções',
        child: Obx(
          () => ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: _homeController.userModel.photoUrl != null
                  ? Image.network(
                      '${_homeController.userModel.photoUrl}',
                      // loadingBuilder: (_, __, ___) {
                      //   return Center(child: const CircularProgressIndicator());
                      // },
                      height: 58,
                      width: 58,
                      errorBuilder: (_, __, ___) {
                        return const Icon(
                          Icons.person,
                          color: Colors.black,
                        );
                      },
                    )
                  : const Icon(Icons.person, color: Colors.black)),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Editar perfil'),
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.userEdit);
              },
              icon: const Icon(Icons.person_outline_outlined),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Sair'),
              onPressed: () {
                _authController.logout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
        ];
      },
    );
  }
}
