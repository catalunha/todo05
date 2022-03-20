import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/user/additional_info/user_additional_info_controller.dart';

class UserAdditionalInfoPage extends StatefulWidget {
  final UserAdditionalInfoController _userController = Get.find();
  UserAdditionalInfoPage({Key? key}) : super(key: key);

  @override
  State<UserAdditionalInfoPage> createState() => _UserAdditionalInfoPageState();
}

class _UserAdditionalInfoPageState extends State<UserAdditionalInfoPage> {
  final _databases = ['Hive', 'Firebase'];
  final _databases2 = [
    ['Hive', 'Local (com Hive)'],
    ['Isar', 'Local (com Isar)'],
    ['Firebase', 'Núvem (com Firebase)'],
    ['CouchBase', 'Núvem (com couchBase)'],
  ];
  String _databaseSelected = 'Hive';
  final doingValueNotifier = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações adicionais do usuário.'),
      ),
      body: Obx(
        () => Visibility(
          visible: widget._userController.getAdditionalInformation.value,
          replacement: const CircularProgressIndicator(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seu cadastro precisa de informações adicionais'),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                Text(
                    '1) Vc deseja usar a opção de (doing/fazendo/em andamento) nas tarefas ?'),
                ValueListenableBuilder(
                  valueListenable: doingValueNotifier,
                  builder: (_, bool value, __) {
                    return CheckboxListTile(
                      title: Text('Doing ?'),
                      value: value,
                      onChanged: (value) {
                        doingValueNotifier.value = value!;
                      },
                    );
                  },
                ),
                Divider(),
                Text('2) Onde salvar suas tarefas. Local ou em núvem ?'),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: DropdownButton<String>(
                      items: _databases2.map((List<String> item) {
                        if (item[0] == 'Isar' || item[0] == 'CouchBase') {
                          return DropdownMenuItem<String>(
                            value: item[0],
                            child: Text(
                              item[1],
                              style: TextStyle(color: Colors.grey),
                            ),
                            enabled: false,
                          );
                        } else {
                          return DropdownMenuItem<String>(
                            value: item[0],
                            child: Text(item[1]),
                            enabled: true,
                          );
                        }
                      }).toList(),
                      onChanged: (novoItemSelecionado) {
                        setState(() {
                          _databaseSelected = novoItemSelecionado!;
                        });
                      },
                      value: _databaseSelected,
                      iconSize: 36,
                      isExpanded: true,
                      elevation: 16,
                    ),
                  ),
                ),
                Text('Sua escolha foi: $_databaseSelected'),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton(
                    child: const Text('Confirmar'),
                    onPressed: () {
                      print('setAdditionalInformation...');
                      widget._userController.setAdditionalInformation(
                          doing: doingValueNotifier.value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
