import 'package:flutter/material.dart';
import 'package:taskly/app/theme/text_theme.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    Key key,
    this.child,
    this.height,
    this.width,
    this.margin,
    this.color,
  }) : super(key: key);

  final Widget child;
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: width,
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
        height: height,
        width: width,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: child,
      ),
    );
  }
}
