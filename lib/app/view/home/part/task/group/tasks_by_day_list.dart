import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo05/app/view/home/part/task/group/tasks_by_day.dart';
import 'package:todo05/app/viewmodel/home/home_controller.dart';

class TasksByDayList extends StatelessWidget {
  final HomeController _homeController = Get.find();

  TasksByDayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
            children: _homeController.tasksDay
                .map(
                  (task) => TasksByDay(tasksDayModel: task),
                )
                .toList(),
          )),
    );
  }
}
