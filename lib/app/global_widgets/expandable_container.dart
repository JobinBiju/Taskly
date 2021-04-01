import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/theme/text_theme.dart';

class ExpandedContainer extends GetView<HomeController> {
  final String icon;
  final String title;
  final String time;
  final String desc;
  const ExpandedContainer({
    Key key,
    this.title,
    this.icon,
    this.time,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 18, left: 25, right: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage('assets/images/containerMask.png'),
              fit: BoxFit.cover,
            ),
            boxShadow: [kLightShadow],
          ),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor.withOpacity(0.85),
            ),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                expandedAlignment: Alignment.centerLeft,
                childrenPadding:
                    EdgeInsets.symmetric(horizontal: 75, vertical: 5),
                backgroundColor: Colors.transparent,
                leading: Container(
                  height: 42,
                  width: 42,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: SvgPicture.asset(icon),
                ),
                title: Text(
                  title,
                  maxLines: 2,
                  style: kSub2HeadTextStyle.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                trailing: Text(
                  time,
                  style: kSub2HeadTextStyle.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                children: [
                  Text(
                    desc,
                    style: kSub2HeadTextStyle.copyWith(
                        fontSize: 12,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  )
                ],
                onExpansionChanged: controller.onExpand,
              ),
            ),
          ),
        );
      },
    );
  }
}
