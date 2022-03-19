import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo05/app/domain/models/task/task_day_model.dart';
import 'package:todo05/app/presentation/controllers/home/home_controller.dart';

class TasksByDay extends StatelessWidget {
  final HomeController _homeController = Get.find();

  final TasksDayModel tasksDayModel;
  TasksByDay({Key? key, required this.tasksDayModel}) : super(key: key);

  final dateFormat = DateFormat('y-MM-dd');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _homeController.loadTasks(tasksDayModel.dateTime);
      },
      borderRadius: BorderRadius.circular(30),
      child: Obx(() => Container(
            // margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _homeController.groupDate.value ==
                      dateFormat.format(tasksDayModel.dateTime)
                  ? Colors.blue.shade200
                  : null,
              border: Border.all(
                width: 1,
                color: Colors.grey.withOpacity(0.8),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              Text(dateFormat.format(tasksDayModel.dateTime)),
              Text(
                  '${tasksDayModel.quantityNotDone} / ${tasksDayModel.quantityDone}'),
            ]),
          )),
    );
  }
}
