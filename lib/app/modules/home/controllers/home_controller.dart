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

  // Hive DB var
  String taskBox = 'tasks';
  int taskIds = 0;

  // variable for expansionTile
  bool isExpanded = false;

  // bools for dashboard view
  bool isCurrentTaskPresent = false;
  bool isUpcommingTaskPresent = false;
  Task currentTask;
  Task upcomingTask;

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
  bool isRepeat = false;
  List<String> icons = [
    'assets/icons/alarm-clock.svg',
    'assets/icons/breakfast.svg',
    'assets/icons/Lunch.svg',
    'assets/icons/notepad.svg',
    'assets/icons/online-learning.svg',
    'assets/icons/settings.svg',
    'assets/icons/treadmill.svg',
    'assets/icons/shopping.svg',
    'assets/icons/celeb.svg',
    'assets/icons/travel.svg',
  ];

  // the list of screens switched by bottom navBar
  final List<Widget> homeViews = [
    DashboardView(),
    TodayTaskView(),
  ];

  // temp var to create each task
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

  // function to toggle repeat switch in BottomSheet
  toggleRepeat(bool newValue) {
    isRepeat = newValue;
    update(['isRepeat', true]);
  }

  // convert time to minutes
  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  // function to sort allTasks based on date & time.
  sortAllTasks() {
    var currDt = DateTime.now();
    allTasks.forEach((ele) {
      if (ele.isRepeat == true) {
        var tmp = ele.taskDate;
        ele.taskDate = DateTime(
          currDt.year,
          currDt.month,
          currDt.day,
          tmp.hour,
          tmp.minute,
        );
      }
    });
    allTasks.sort((a, b) {
      var aD = a.taskDate.toString();
      var bD = b.taskDate.toString();
      return aD.compareTo(bD);
    });
  }

  // Funtion to generate dailyTask
  dailyTask() {
    todayTasks = [];
    var currDt = DateTime.now();
    if (allTasks.length != 0) {
      allTasks.forEach((element) {
        if (element.taskDate.day == currDt.day &&
            element.taskDate.month == currDt.month &&
            element.taskDate.year == currDt.year) {
          todayTasks.add(element);
        }
      });
      todayTasks.sort((a, b) {
        var aT = toDouble(timeConvert(a.startTime));
        var bT = toDouble(timeConvert(b.startTime));
        return aT.compareTo(bT);
      });
      todayTasks.forEach((element) {
        print(element.startTime);
      });
      update([1, true]);
    }
  }

  // function to add task via bottomSheet
  addTask() async {
    tempTask = Task();
    var box = await Hive.openBox(taskBox);
    var modDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    tempTask.taskImage = selectedIcon;
    tempTask.taskTitle = titleController.text;
    tempTask.taskDesc = descController.text;
    tempTask.taskDate = modDate;
    tempTask.startTime = formatDate(
        DateTime(2020, 08, 1, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, " ", am]).toString();
    tempTask.isRepeat = isRepeat;
    print(modDate.toString());
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
    sortAllTasks();
    dailyTask();
    update([1, true]);
    Get.back();
  }

  // function to update task
  updateTask(Task task) async {
    sortAllTasks();
    dailyTask();
    update([1, true]);
  }

  // function to read task from database
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
      tmp.isRepeat = taskMap['isRepeat'];
      taskList.add(tmp);
      print(taskMap);
    }
    return taskList;
  }

  // function to delete task by ID
  deleteTask(int taskId) async {
    var box = await Hive.openBox(taskBox);
    await box.deleteAt(taskId);
    dailyTask();
  }

  reWriteTasks() async {
    var box = await Hive.openBox(taskBox);
    // ignore: unused_local_variable
    int id = await box.clear();
    allTasks.forEach((element) async {
      Map<String, dynamic> newTaskMap = element.toJson();
      // ignore: unused_local_variable
      int idOfTask = await box.add(newTaskMap);
    });
    Hive.close();
  }

  // ExpandedContainer
  void onExpand(bool value) {
    isExpanded = value;
    update();
  }

  // setDateFuntion bottomSheet
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

  // setTimeFuntion bottomSheet
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

  // function to convert time from string to TimeOfDay
  TimeOfDay timeConvert(String normTime) {
    int hour;
    int minute;
    String ampm = normTime.substring(normTime.length - 2);
    String result = normTime.substring(0, normTime.indexOf(' '));
    if (ampm == 'AM' && int.parse(result.split(":")[1]) != 12) {
      hour = int.parse(result.split(':')[0]);
      if (hour == 12) hour = 0;
      minute = int.parse(result.split(":")[1]);
    } else {
      hour = int.parse(result.split(':')[0]) - 12;
      if (hour <= 0) {
        hour = 24 + hour;
      }
      minute = int.parse(result.split(":")[1]);
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void onInit() async {
    super.onInit();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    allTasks = await getTasks();
    sortAllTasks();
    reWriteTasks();
    dailyTask();
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
