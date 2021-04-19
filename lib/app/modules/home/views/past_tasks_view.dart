import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskly/app/global_widgets/bottom_sheet.dart';
import 'package:taskly/app/global_widgets/expandable_container.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/theme/text_theme.dart';

class PastTasksView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                'Past Tasks',
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
                      final task = controller.pastTasks[index];
                      return Slidable(
                        actionPane: SlidableBehindActionPane(),
                        actionExtentRatio: 0.2,
                        controller: controller.slideC,
                        child: ExpandedContainer(
                          icon: task.taskImage,
                          title: task.taskTitle,
                          time: task.startTime,
                          desc: task.taskDesc,
                          ifDate: true,
                          date: DateFormat.yMMMd().format(task.taskDate),
                        ),
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: Get.width * 0.05,
                                left: Get.width * 0.07),
                            child: Container(
                              padding: EdgeInsets.all(0),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 26,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    controller.slideC.activeState?.close();
                                    Slidable.of(context)?.close();
                                    controller.preUpdateTask(task);
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return BottomSheetContent(
                                          buttonText: 'Update Task',
                                          onSubmit: () {
                                            controller.updateTask(task);
                                          },
                                        );
                                      },
                                    );
                                  }),
                            ),
                          ),
                        ],
                        secondaryActions: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: Get.width * 0.05,
                                right: Get.width * 0.07),
                            child: Container(
                              padding: EdgeInsets.all(0),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 26,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    controller.slideC.activeState?.close();
                                    Slidable.of(context)?.close();
                                    controller.customDialogDel(context, task);
                                  }),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: controller.pastTasks.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
