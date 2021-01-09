import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/proceed_button.dart';
import 'package:taskly/app/modules/welcome/controllers/welcome_controller.dart';
import 'package:taskly/app/modules/welcome/views/login_view.dart';
import 'package:taskly/app/theme/text_theme.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding:
            EdgeInsets.only(top: size.height * 0.08, left: size.width * 0.06),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/taskly_logo.svg',
                  height: size.height * 0.05,
                ),
                SizedBox(width: size.width * 0.03),
                Text(
                  'Taskly',
                  style: kSub2HeadTextStyle,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.035),
            Text(
              'Developers\'s life is a Mess',
              style: kHeadTextStyle.copyWith(
                  fontSize: 32, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'Get Organized',
              style: kSub2HeadTextStyle,
            ),
            SizedBox(height: size.height * 0.04),
            SvgPicture.asset(
              'assets/icons/laptopPerson2.svg',
              height: size.height * 0.44,
            ),
            SizedBox(height: size.height * 0.062),
            Align(
              alignment: Alignment.center,
              child: ProceedButton(
                size: size,
                onPress: () {
                  Get.to(LoginView());
                },
                title: 'Start',
              ),
            )
          ],
        ),
      ),
    );
  }
}
