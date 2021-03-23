import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskly/app/theme/text_theme.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    this.margin,
    this.color,
    this.svgAsset,
    this.title,
    this.time,
  });

  final EdgeInsetsGeometry margin;
  final Color color;
  final String svgAsset;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Container(
      height: size.height * 0.095,
      width: double.infinity,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage('assets/images/containerMask.png'),
            fit: BoxFit.cover,
          ),
          boxShadow: [kLightShadow]),
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.095,
        width: double.infinity,
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 42,
              width: 42,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: SvgPicture.asset(svgAsset),
            ),
            Container(
              width: size.width * 0.4,
              child: Text(
                title,
                maxLines: 2,
                style: kSub2HeadTextStyle.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              time,
              style: kSub2HeadTextStyle.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
