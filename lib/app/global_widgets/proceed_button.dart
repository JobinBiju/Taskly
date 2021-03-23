import 'package:flutter/material.dart';
import 'package:taskly/app/theme/text_theme.dart';

class ProceedButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final Color buttonColor;
  const ProceedButton({
    @required this.size,
    @required this.title,
    @required this.onPress,
    this.buttonColor,
  });

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
        style: kSub2HeadTextStyle.copyWith(
            color: Theme.of(context).primaryColorLight),
      ),
      color: buttonColor ?? Color(0xffffc045),
      splashColor: buttonColor.withOpacity(0.8) ?? Color(0xfffdb827),
      highlightColor: buttonColor.withOpacity(0.8) ?? Color(0xfffdb827),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.05)),
    );
  }
}
