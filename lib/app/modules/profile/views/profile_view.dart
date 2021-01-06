import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/user_avatar.dart';
import 'package:taskly/app/modules/profile/controllers/profile_controller.dart';
import 'package:taskly/app/modules/settings/views/settings_view.dart';
import 'package:taskly/app/theme/text_theme.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: size.height * 0.1),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              height: size.height * 0.18,
              width: size.width * 0.90,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.85),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [kDefaultShadow],
              ),
              child: Row(
                children: [
                  UserAvatar(radius: size.width * 0.085),
                  SizedBox(width: size.width * 0.045),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jobin Biju',
                        style: kSub2HeadTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: size.height * 0.007),
                      Text(
                        'jobinbiju9090@gmail.com',
                        style: kSub2HeadTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 16,
                        ),
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
                  EdgeInsets.symmetric(horizontal: size.width * 0.08),
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
                size: size.width * 0.06,
              ),
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.08),
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
                size: size.width * 0.06,
              ),
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.08),
              onTap: () {},
              title: Text(
                'Log out',
                style: kSub2HeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Theme.of(context).primaryColorDark,
                size: size.width * 0.06,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
