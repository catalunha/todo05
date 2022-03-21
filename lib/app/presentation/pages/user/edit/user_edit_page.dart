import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/user/edit/user_edit_controller.dart';
import 'package:todo05/app/presentation/pages/utils/part/app_text_form_field.dart';
import 'package:validatorless/validatorless.dart';

class UserEditPage extends StatefulWidget {
  UserEditPage({Key? key}) : super(key: key);
  final UserEditController _userEditController = Get.find();

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameTec = TextEditingController();
  final _photoUrlTec = TextEditingController();
  final _databases = [
    ['Hive', 'Local (com Hive)'],
    ['Isar', 'Local (com Isar)'],
    ['Firebase', 'Núvem (com Firebase)'],
    ['CouchBase', 'Núvem (com couchBase)'],
  ];
  final _databaseSelectedValueNotifier = ValueNotifier<String>('Hive');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _displayNameTec.text =
        widget._userEditController.userModel!.displayName ?? "";
    _photoUrlTec.text = widget._userEditController.userModel?.photoUrl ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text('Editar User'),
              ),
              SizedBox(height: 30),
              AppTextFormField(
                label: 'Nome',
                controller: _displayNameTec,
                // validator: Validatorless.required('Nome obrigatório'),
              ),
              SizedBox(
                height: 30,
              ),
              AppTextFormField(
                label: 'Foto',
                controller: _photoUrlTec,
                // validator: Validatorless.required('Foto obrigatório'),
              ),
              SizedBox(height: 20),
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
                    items: _databases.map((List<String> item) {
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
                        _databaseSelectedValueNotifier.value =
                            novoItemSelecionado!;
                      });
                    },
                    value: _databaseSelectedValueNotifier.value,
                    iconSize: 36,
                    isExpanded: true,
                    elevation: 16,
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _databaseSelectedValueNotifier,
                builder: (_, String value, __) {
                  return Text('Sua escolha foi: $value');
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: context.primaryColor,
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._userEditController.updateData(
              displayName: _displayNameTec.text,
              photoUrl: _photoUrlTec.text,
              database: _databaseSelectedValueNotifier.value,
            );
            Get.back();
          }
        },
        label: Text(
          'Salvar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
