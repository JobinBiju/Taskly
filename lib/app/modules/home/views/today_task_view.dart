import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/expandable_container.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/theme/text_theme.dart';

class TodayTaskView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 25, right: 25),
            child: Text(
              'Today\'s Tasks',
              style: kSubHeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
          SizedBox(height: Get.height * 0.012),
          GetBuilder<HomeController>(
            id: 1,
            builder: (controller) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final task = controller.todayTasks[index];
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.15,
                      child: ExpandedContainer(
                        icon: task.taskImage,
                        title: task.taskTitle,
                        time: task.startTime,
                        desc: task.taskDesc,
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20, left: 20),
                          child: IconButton(
                              icon: Icon(Icons.edit, size: 30),
                              onPressed: () {
                                controller.slideC.activeState?.close();
                                Slidable.of(context)?.close();
                              }),
                        ),
                      ],
                      secondaryActions: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20, right: 30),
                          child: IconButton(
                              icon: Icon(Icons.delete, size: 30),
                              onPressed: () {
                                controller.slideC.activeState?.close();
                                Slidable.of(context)?.close();
                              }),
                        ),
                      ],
                    );
                  },
                  itemCount: controller.todayTasks.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
