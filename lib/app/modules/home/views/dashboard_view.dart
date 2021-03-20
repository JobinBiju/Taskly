import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/decorated_Container.dart';
import 'package:taskly/app/global_widgets/user_avatar.dart';
import 'package:taskly/app/modules/profile/views/profile_view.dart';
import 'package:taskly/app/theme/text_theme.dart';

class DashboardView extends GetView {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello, Jobin',
                style: kSubHeadTextStyle.copyWith(
                    color: Theme.of(context).primaryColorDark),
              ),
              GestureDetector(
                onTap: () => Get.to(() => ProfileView()),
                child: UserAvatar(
                  radius: size.width * 0.062,
                ),
              ),
            ],
          ),
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
          SizedBox(height: size.height * 0.038),
          DecoratedContainer(
            margin: EdgeInsets.only(bottom: 20),
            color: Theme.of(context).primaryColor.withOpacity(0.85),
            svgAsset: 'assets/icons/alarm-clock.svg',
            title: 'Wake Up',
            time: '7:00 am',
          ),
          SizedBox(height: size.height * 0.04),
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
          SizedBox(height: size.height * 0.038),
          DecoratedContainer(
            margin: EdgeInsets.only(bottom: 20),
            color: Theme.of(context).primaryColor.withOpacity(0.85),
            svgAsset: 'assets/icons/online-learning.svg',
            title: 'Help a friend with a homework',
            time: '7:30 am',
          ),
        ],
      ),
    );
  }
}
