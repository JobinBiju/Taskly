import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/user_avatar.dart';
import 'package:taskly/app/modules/profile/views/profile_view.dart';
import 'package:taskly/app/theme/text_theme.dart';

class DashboardView extends GetView {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.08,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hello, Jobin',
                  style: kSubHeadTextStyle,
                ),
                GestureDetector(
                  onTap: () => Get.to(ProfileView()),
                  child: UserAvatar(
                    radius: size.width * 0.062,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Current Task',
                  style: kSub2HeadTextStyle,
                ),
                GestureDetector(
                  onTap: () {},
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
          )
        ],
      ),
    );
  }
}
