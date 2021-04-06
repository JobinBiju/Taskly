import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/decorated_Container.dart';
import 'package:taskly/app/global_widgets/user_avatar.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/modules/home/views/all_tasks_view.dart';
import 'package:taskly/app/modules/profile/views/profile_view.dart';
import 'package:taskly/app/theme/text_theme.dart';

class DashboardView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
      height: size.height,
      width: size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.08,
          ),
          GetBuilder<HomeController>(
              id: 7,
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, ${controller.userName}',
                      style: kSubHeadTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => ProfileView()),
                      child: UserAvatar(
                        ismale: controller.isMale,
                        radius: size.width * 0.062,
                      ),
                    ),
                  ],
                );
              }),
          SizedBox(height: size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Current Task',
                style: kSub2HeadTextStyle.copyWith(
                    color: Theme.of(context).primaryColorDark),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => AllTasksView());
                },
                child: Text(
                  'View all tasks',
                  style: kSub2HeadTextStyle.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.038),
          GetBuilder<HomeController>(
              id: 3,
              builder: (_) {
                return controller.isCurrentTaskPresent
                    ? DecoratedContainer(
                        margin: EdgeInsets.only(bottom: 20),
                        color: Theme.of(context).primaryColor.withOpacity(0.85),
                        svgAsset: controller.currentTask.taskImage,
                        title: controller.currentTask.taskTitle,
                        time: controller.currentTask.startTime,
                      )
                    : Center(
                        child: Text(
                          "Nothing Here",
                          style: kSub2HeadTextStyle.copyWith(
                              fontSize: 12,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      );
              }),
          SizedBox(height: size.height * 0.06),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Upcoming Task',
                style: kSub2HeadTextStyle.copyWith(
                    color: Theme.of(context).primaryColorDark),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => AllTasksView());
                },
                child: Text(
                  'View all tasks',
                  style: kSub2HeadTextStyle.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.038),
          GetBuilder<HomeController>(
              id: 3,
              builder: (_) {
                return controller.isUpcommingTaskPresent
                    ? DecoratedContainer(
                        margin: EdgeInsets.only(bottom: 20),
                        color: Theme.of(context).primaryColor.withOpacity(0.85),
                        svgAsset: controller.upcomingTask.taskImage,
                        title: controller.upcomingTask.taskTitle,
                        time: controller.upcomingTask.startTime,
                      )
                    : Center(
                        child: Text(
                          "Nothing Here",
                          style: kSub2HeadTextStyle.copyWith(
                              fontSize: 12,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      );
              }),
        ],
      ),
    );
  }
}
