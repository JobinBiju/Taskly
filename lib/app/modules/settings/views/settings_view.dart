import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taskly/app/modules/settings/controllers/settings_controller.dart';
import 'package:taskly/app/theme/text_theme.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding:
            EdgeInsets.only(top: size.height * 0.08, left: size.width * 0.05),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: kSubHeadTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.04),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Theme',
                    style: kSub2HeadTextStyle.copyWith(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  GetBuilder<SettingsController>(
                    init: SettingsController(),
                    builder: (controller) {
                      return DropdownButton(
                        value: controller.selectedTheme,
                        underline: Container(color: Colors.transparent),
                        hint: Text('Select'),
                        items: controller.themes.map(
                          (String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value!),
                            );
                          },
                        ).toList(),
                        onChanged: controller.changeTheme,
                        dropdownColor: Theme.of(context).primaryColorLight,
                      );
                    },
                  )
                ],
              ),
              leading: Icon(
                FontAwesomeIcons.palette,
                color: Theme.of(context).primaryColor,
                size: size.width * 0.06,
              ),
            ),
            ListTile(
              title: Text(
                'Drink Water Notify',
                style: kSub2HeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 17,
                ),
              ),
              trailing: GetBuilder<SettingsController>(
                init: controller,
                builder: (_) {
                  return Switch(
                    value: controller.drinkWater!,
                    onChanged: controller.toggleWater,
                    activeTrackColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                        activeColor: Theme.of(context).primaryColor,
                  );
                },
              ),
              leading: Icon(
                Icons.opacity,
                color: Theme.of(context).primaryColor,
                size: size.width * 0.07,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
