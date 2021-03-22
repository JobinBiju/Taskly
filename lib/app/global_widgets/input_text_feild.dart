import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/app/theme/text_theme.dart';

class InputTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color hintTextColor;
  final Color contentTextColor;
  final Color textFeildColor;
  InputTextFormField({
    @required this.hintText,
    this.controller,
    this.hintTextColor,
    this.contentTextColor,
    this.textFeildColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      decoration: BoxDecoration(
        color: textFeildColor ?? Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        style: kSub2HeadTextStyle.copyWith(
            color: contentTextColor ?? Color(0xff3a4750), fontSize: 16),
        cursorHeight: 18,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kSub2HeadTextStyle.copyWith(
            fontSize: 16,
            color: hintTextColor ?? Color(0xff8E8E8E),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
