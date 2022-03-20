import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/auth/auth_controller.dart';

class ErroPage extends StatelessWidget {
  final String? errorMessage = Get.arguments;
  ErroPage({
    Key? key,
  }) : super(key: key);

  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erro no acesso ao sistema.'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Se você esta vendo esta tela.'),
            Text('Existe um erro no seu acesso.'),
            Text('Informe o texto a seguir ao administrador.'),
            const SizedBox(height: 20),
            Text(errorMessage ?? 'Descrição do erro não informado.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _authController.logout(),
              child: const Text('Sair'),
            )
          ],
        ),
      ),
    );
  }
}
