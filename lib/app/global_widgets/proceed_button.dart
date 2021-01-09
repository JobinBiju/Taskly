import 'package:flutter/material.dart';
import 'package:taskly/app/theme/text_theme.dart';

class ProceedButton extends StatelessWidget {
  final String title;
  final Function onPress;
  const ProceedButton({
    Key key,
    this.title,
    this.onPress,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      height: size.height * 0.066,
      minWidth: size.width * 0.4,
      elevation: 0,
      child: Text(
        title,
        style: kSub2HeadTextStyle,
      ),
      color: Color(0xffffc045),
      splashColor: Color(0xfffdb827),
      highlightColor: Color(0xfffdb827),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.05)),
    );
  }
}
