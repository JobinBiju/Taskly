import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    Key key,
    this.child,
    @required this.size,
  }) : super(key: key);

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.18,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: AssetImage('assets/images/containerMask.png'),
            fit: BoxFit.cover),
      ),
      child: Container(
        height: size.height * 0.18,
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor.withOpacity(0.6),
        ),
        child: child,
      ),
    );
  }
}
