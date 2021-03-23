import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/input_text_feild.dart';
import 'package:taskly/app/global_widgets/proceed_button.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/modules/welcome/views/login_view.dart';
import 'package:taskly/app/theme/text_theme.dart';

class HomeView extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.navBarSwitcher()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  height: Get.height * 0.57,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 30),
                      InputTextFormField(
                        hintText: 'Tittle',
                        textFeildColor: Theme.of(context).primaryColorLight,
                        contentTextColor: Theme.of(context).primaryColorDark,
                      ),
                      SizedBox(height: 25),
                      InputTextFormField(
                        hintText: 'Description',
                        textFeildColor: Theme.of(context).primaryColorLight,
                        contentTextColor: Theme.of(context).primaryColorDark,
                      ),
                      SizedBox(height: 25),
                      SizedBox(height: 46),
                      SizedBox(height: 25),
                      ProceedButton(
                        size: Get.size,
                        title: 'Create Task',
                        buttonColor: Theme.of(context).primaryColor,
                        onPress: () {},
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Obx(
        () => BubbleBottomBar(
          opacity: 0,
          fabLocation: BubbleBottomBarFabLocation.end,
          currentIndex: controller.currentIndex,
          backgroundColor: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          hasInk: false,
          elevation: 7,
          inkColor: Colors.black54,
          hasNotch: true,
          onTap: (index) => controller.currentIndex = index,
          items: [
            BubbleBottomBarItem(
              backgroundColor: Colors.grey,
              title: Text(
                'Home',
                style: kSub2HeadTextStyle.copyWith(fontSize: 16),
              ),
              icon: Icon(
                FontAwesomeIcons.home,
                color: Theme.of(context).primaryColorDark,
              ),
              activeIcon: Icon(FontAwesomeIcons.home,
                  color: Theme.of(context).primaryColor),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.grey,
              title: Text(
                'Tasks',
                style: kSub2HeadTextStyle.copyWith(fontSize: 16),
              ),
              icon: Icon(
                FontAwesomeIcons.clock,
                color: Theme.of(context).primaryColorDark,
              ),
              activeIcon: Icon(FontAwesomeIcons.clock,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
