import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/decorated_Container.dart';
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
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ExpandedContainer(
                  icon: 'assets/images/containerMask.png',
                  title: 'Wake Up',
                  time: '7:30 am',
                  desc:
                      'Rise and shine!khfgiodfsjhjkdfjhokdfjhofjhhhjoihjrhjoirtjhiojhfdjhfdjho',
                );
              },
              itemCount: 7,
            ),
          )
        ],
      ),
    );
  }
}
