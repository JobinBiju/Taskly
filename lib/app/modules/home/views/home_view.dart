import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/theme/text_theme.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
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
                    'https://img.icons8.com/color/48/000000/circled-user-male-skin-type-6--v1.png%22',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
