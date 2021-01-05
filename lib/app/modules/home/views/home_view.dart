import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/theme/text_theme.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.07,
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
                  CircleAvatar(
                    radius: size.width * 0.055,
                    backgroundImage: NetworkImage(
                      'https://img.icons8.com/color/48/000000/user-male-circle--v1.png',
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColorDark,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Obx(
        () => BubbleBottomBar(
          opacity: 0,
          fabLocation: BubbleBottomBarFabLocation.end,
          currentIndex: controller.currentIndex.value,
          backgroundColor: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          hasInk: false,
          elevation: 7,
          inkColor: Colors.black54,
          hasNotch: true,
          onTap: (v) {
            controller.currentIndex.value = v;
          },
          items: [
            BubbleBottomBarItem(
              backgroundColor: Colors.grey,
              title: Text('Home'),
              icon: Icon(
                FontAwesomeIcons.home,
                color: Theme.of(context).primaryColorDark,
              ),
              activeIcon: Icon(FontAwesomeIcons.home,
                  color: Theme.of(context).primaryColor),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.grey,
              title: Text('Tasks'),
              icon: Icon(
                FontAwesomeIcons.clock,
                color: Theme.of(context).primaryColorDark,
              ),
              activeIcon: Icon(FontAwesomeIcons.clock,
                  color: Theme.of(context).primaryColor),
            ),
            // BubbleBottomBarItem(
            //   backgroundColor: Colors.grey,
            //   title: Text('Settings'),
            //   icon: Icon(
            //     FontAwesomeIcons.cog,
            //     color: Theme.of(context).primaryColorDark,
            //   ),
            //   activeIcon: Icon(FontAwesomeIcons.cog,
            //       color: Theme.of(context).primaryColor),
            // ),
          ],
        ),
      ),
    );
  }
}
