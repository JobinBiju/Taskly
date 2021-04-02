import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskly/app/data/model/task_model.dart';
import 'package:taskly/app/modules/home/views/dashboard_view.dart';
import 'package:taskly/app/modules/home/views/today_task_view.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class HomeController extends GetxController {
  // bottom nav current index.
  var _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;
  set currentIndex(index) => this._currentIndex.value = index;

  String taskBox = 'tasks';
  int taskIds = 0;

  // variable for expansionTile
  bool isExpanded = false;

  // bools for dashboard view
  bool isCurrentTaskPresent = false;
  bool isUpcommingTaskPresent = false;

  // controllers and var for bottomSheet TextFeilds
  TextEditingController titleController;
  TextEditingController descController;
  TextEditingController dateController;
  TextEditingController timeController;
  String selectedIcon;
  DateTime selectedDate;
  TimeOfDay selectedTime;
  String setTime, setDate;
  String hour, minute, time;
  List<String> icons = [
    'assets/icons/alarm-clock.svg',
    'assets/icons/breakfast.svg',
    'assets/icons/Lunch.svg',
    'assets/icons/notepad.svg',
    'assets/icons/online-learning.svg',
    'assets/icons/settings.svg',
    'assets/icons/treadmill.svg',
  ];

  // the list of screens switched by bottom navBar
  final List<Widget> homeViews = [
    DashboardView(),
    TodayTaskView(),
  ];

  Task tempTask;
  // task lists
  List<Task> allTasks = [];
  List<Task> todayTasks = [];

  // function to return correct view on bottom navBar switch
  Widget navBarSwitcher() {
    return homeViews.elementAt(currentIndex);
  }

  // change icon in bottomSheet
  changeIcon(String newIcon) {
    selectedIcon = newIcon;
    update(['dropDownIcon', true]);
  }

  // function to add task via bottomSheet
  addTask() async {
    tempTask = Task();
    var box = await Hive.openBox(taskBox);
    tempTask.taskImage = selectedIcon;
    tempTask.taskTitle = titleController.text;
    tempTask.taskDesc = descController.text;
    tempTask.taskDate = selectedDate.toString();
    tempTask.startTime = formatDate(
        DateTime(2020, 08, 1, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, " ", am]).toString();
    allTasks.add(tempTask);
    Map<String, dynamic> taskMap = tempTask.toJson();
    int idOfTask = await box.add(taskMap);
    taskIds = idOfTask;
    Hive.close();
    titleController.text = '';
    descController.text = '';
    selectedDate = DateTime.now();
    dateController.text = DateFormat.yMMMd().format(selectedDate);
    selectedTime = TimeOfDay(hour: 00, minute: 00);
    timeController.text = formatDate(
      DateTime(2020, 08, 1, selectedTime.hour, selectedTime.minute),
      [hh, ':', nn, " ", am],
    ).toString();
    selectedIcon = icons.first;
    update([1, true]);
    Get.back();
  }

  updateTask(int index, Task task1) async {
    var box = await Hive.openBox(taskBox);
    var newTaskMap = task1.toJson();
    box.putAt(index, newTaskMap);
    Hive.close();
  }

  Future<List<Task>> getTasks() async {
    var box = await Hive.openBox(taskBox);
    List<Task> taskList = [];
    for (int i = 0; i < box.length; i++) {
      var taskMap = box.getAt(i).map((k, e) => MapEntry(k.toString(), e));
      Task tmp = Task();
      tmp.taskImage = taskMap['taskImage'];
      tmp.taskTitle = taskMap['taskTitle'];
      tmp.taskDesc = taskMap['taskDesc'];
      tmp.startTime = taskMap['startTime'];
      tmp.taskDate = taskMap['taskDate'];
      taskList.add(tmp);
      print(taskMap);
    }
    print(taskList);
    return taskList;
  }

  deleteTask(int taskId) async {
    var box = await Hive.openBox(taskBox);
    await box.deleteAt(taskId);
  }

  // ExpandedContainer
  void onExpand(bool value) {
    isExpanded = value;
    update();
  }

  // dateFuntion bottomSheet
  Future<Null> selectDate(BuildContext context) async {
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
  void onInit() async {
    super.onInit();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    allTasks = await getTasks();
    update([1, true]);
    titleController = TextEditingController();
    descController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    selectedDate = DateTime.now();
    dateController.text = DateFormat.yMMMd().format(selectedDate);
    selectedTime = TimeOfDay(hour: 00, minute: 00);
    timeController.text = formatDate(
        DateTime(2020, 08, 1, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, " ", am]).toString();
    selectedIcon = icons.first;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    dateController.dispose();
    timeController.dispose();
  }
}
