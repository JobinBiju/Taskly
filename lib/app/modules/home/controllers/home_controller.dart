import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/app/modules/home/views/dashboard_view.dart';
import 'package:taskly/app/modules/home/views/today_task_view.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class HomeController extends GetxController {
  // bottom nav current index.
  var _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;
  set currentIndex(index) => this._currentIndex.value = index;

  // variable for expansionTile
  bool isExpanded = false;

  // bools for dashboard view
  bool isCurrentTaskPresent = false;
  bool isUpcommingTaskPresent = false;

  // controllers for bottomSheet TextFeilds
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime selectedDate;
  TimeOfDay selectedTime;
  String setTime, setDate;
  String hour, minute, time;

  // the list of screens switched by bottom navBar
  final List<Widget> homeViews = [
    DashboardView(),
    TodayTaskView(),
  ];

  // function to return correct view on bottom navBar switch
  Widget navBarSwitcher() {
    return homeViews.elementAt(currentIndex);
  }

  // ExpandedContainer
  void onExpand(bool value) {
    isExpanded = value;
    update();
  }

  // dateFuntion bottomSheet
  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectedDate = picked;
      dateController.text = DateFormat.yMMMd().format(selectedDate);
      update();
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      selectedTime = picked;
      hour = selectedTime.hour.toString();
      minute = selectedTime.minute.toString();
      time = hour + ' : ' + minute;
      timeController.text = time;
      timeController.text = formatDate(
          DateTime(2020, 08, 1, selectedTime.hour, selectedTime.minute),
          [hh, ':', nn, " ", am]).toString();
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    selectedDate = DateTime.now();
    dateController.text = DateFormat.yMMMd().format(selectedDate);
    selectedTime = TimeOfDay(hour: 00, minute: 00);
    timeController.text = formatDate(
        DateTime(2020, 08, 1, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, " ", am]).toString();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
