import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo05/app/domain/models/task/task_model.dart';
import 'package:todo05/app/presentation/controllers/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel taskModel;
  final dateFormat = DateFormat('dd/MM/y');
  final HomeController _homeController = Get.find();

  Task({Key? key, required this.taskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // BoxShadow(color: Colors.grey),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          // contentPadding: EdgeInsets.all(8),
          leading: Checkbox(
            value: taskModel.itsDone,
            onChanged: (value) {
              _homeController.toggleDoneTask(taskModel);
            },
          ),
          onTap: () {
            _homeController.editTask(taskModel.uuid);
          },
          title: Text(
            taskModel.description,
            style: TextStyle(
              decoration: taskModel.itsDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(taskModel.date),
            style: TextStyle(
              decoration: taskModel.itsDone ? TextDecoration.lineThrough : null,
            ),
          ),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20),
          //   side: BorderSide(width: 1),
          // ),
        ),
      ),
    );
  }
}
