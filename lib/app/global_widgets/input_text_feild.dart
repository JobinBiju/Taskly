import 'package:flutter/material.dart';
import 'package:taskly/app/theme/text_theme.dart';

class InputTextFormField extends StatelessWidget {
  final String hintText;
  const InputTextFormField({
    Key key,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      decoration: BoxDecoration(
        color: Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        style:
            kSub2HeadTextStyle.copyWith(color: Color(0xff3a4750), fontSize: 16),
        cursorHeight: 18,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kSub2HeadTextStyle.copyWith(
            fontSize: 16,
            color: Color(0xff8E8E8E),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
