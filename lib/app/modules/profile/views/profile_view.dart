import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/user_avatar.dart';
import 'package:taskly/app/modules/profile/controllers/profile_controller.dart';
import 'package:taskly/app/modules/profile/views/settings_view.dart';
import 'package:taskly/app/theme/text_theme.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: size.height * 0.07),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: size.height * 0.2,
              width: size.width * 0.95,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  UserAvatar(radius: size.width * 0.09),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jobin Biju',
                        style: kSub2HeadTextStyle.copyWith(
                            color: Theme.of(context).primaryColorLight),
                      ),
                      Text(
                        'jobinbiju9090@gmail.com',
                        style: kSub2HeadTextStyle.copyWith(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.07),
              onTap: () {},
              title: Text(
                'Account',
                style: kSub2HeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              leading: Icon(
                FontAwesomeIcons.userEdit,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.07),
              onTap: () {
                Get.to(SettingsView());
              },
              title: Text(
                'Settings',
                style: kSub2HeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              leading: Icon(
                FontAwesomeIcons.cog,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
