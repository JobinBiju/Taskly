import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';

import '../../../../constants.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Text('Good Morning',
                style: GoogleFonts.lato(textStyle: kHeadTextStyle)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
            child: Text(
              'Jobin Biju',
              style: GoogleFonts.lato(textStyle: kSubHeadTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
