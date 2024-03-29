import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo05/app/presentation/controllers/task/append/task_append_controller.dart';
import 'package:todo05/app/presentation/pages/task/append/part/calendar_button.dart';
import 'package:todo05/app/presentation/pages/utils/part/app_text_form_field.dart';
import 'package:validatorless/validatorless.dart';

class TaskAppendPage extends StatefulWidget {
  final TaskAppendController _taskCreateController = Get.find();

  TaskAppendPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskAppendPage> createState() => _TaskAppendPageState();
}

class _TaskAppendPageState extends State<TaskAppendPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    _descriptionTec.text =
        widget._taskCreateController.taskModel?.description ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionTec.dispose();
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
                child: Text(
                  '${widget._taskCreateController.taskModel == null ? "Criar" : "Editar"} task',
                  // style: context.titleStyle.copyWith(
                  //   fontSize: 20,
                  // ),
                ),
              ),
              SizedBox(height: 30),
              AppTextFormField(
                label: 'Descrição',
                controller: _descriptionTec,
                validator: Validatorless.required('Descrição obrigatória'),
              ),
              SizedBox(height: 20),
              CalendarButton(),
              Visibility(
                visible: widget._taskCreateController.taskModel != null,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.delete_forever,
                    ),
                    onPressed: () {
                      widget._taskCreateController.deleteByUuid(
                          widget._taskCreateController.taskModel!.uuid);
                    },
                    label: const Text('Apagar esta task'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: context.primaryColor,
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._taskCreateController.append(_descriptionTec.text);
            Get.back();
          }
        },
        label: Text(
          'Salvar task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
