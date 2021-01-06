import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayTaskView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'TodayTaskView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
