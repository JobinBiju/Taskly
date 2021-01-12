import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/decorated_Container.dart';
import 'package:taskly/app/global_widgets/user_avatar.dart';
import 'package:taskly/app/modules/profile/views/profile_view.dart';
import 'package:taskly/app/theme/text_theme.dart';

class DashboardView extends GetView {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                onTap: () => Get.to(ProfileView()),
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
          SizedBox(height: size.height * 0.04),
          DecoratedContainer(
              height: size.height * 0.1,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .primaryColorLight
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5)),
                    child: SvgPicture.asset('assets/icons/breakfast.svg'),
                  ),
                  Text(
                    'Wake Up',
                    style: kSub2HeadTextStyle.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight),
                  ),
                  SizedBox(width: 40),
                  Text(
                    '7:00 am',
                    style: kSub2HeadTextStyle.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
