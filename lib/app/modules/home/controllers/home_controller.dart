import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskly/app/data/model/task_model.dart';
import 'package:taskly/app/data/services/notification_service.dart';
import 'package:taskly/app/modules/home/views/dashboard_view.dart';
import 'package:taskly/app/modules/home/views/today_task_view.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:taskly/app/theme/text_theme.dart';

class HomeController extends GetxController {
  // bottom nav current index.
  var _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;
  set currentIndex(index) => this._currentIndex.value = index;

  // Hive DB var
  String taskBox = 'tasks';
  int taskIds = 0;

  // instance of Get Storage
  final userData = GetStorage();

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

  // allTasks slidable
  SlidableController slideC;

  // the list of screens switched by bottom navBar
  final List<Widget> homeViews = [
    DashboardView(),
    TodayTaskView(),
  ];

  // temp var to create each task
  Task tempTask;

  // task lists
  List<Task> allTasks = [];
  List<Task> commingTasks = [];
  List<Task> pastTasks = [];
  List<Task> todayTasks = [];

  // userData
  String userName;
  bool isMale = false;

  // instance of notification Plugin
  NotificationPlugin nPlugin;

  // function to return correct view on bottom navBar switch
  Widget navBarSwitcher() {
    return homeViews.elementAt(currentIndex);
  }

  // ExpandedContainer
  void onExpand(bool value) {
    isExpanded = value;
    update();
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
    pastTasks.clear();
    commingTasks.clear();
    List<Task> tmpPastTasks = [];
    allTasks.forEach((element) {
      if (element.taskDate.isBefore(currDt)) {
        tmpPastTasks.add(element);
      } else {
        commingTasks.add(element);
      }
    });
    pastTasks = tmpPastTasks.reversed.toList();
  }

  // Function to generate dailyTask
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
    controllerReset();
    taskRoutine();
    update([1, true]);
    Get.back();
  }

  // preUpdates
  preUpdateTask(Task task) {
    selectedIcon = task.taskImage;
    titleController.text = task.taskTitle;
    descController.text = task.taskDesc;
    selectedTime = timeConvert(task.startTime);
    timeController.text = formatDate(
        DateTime(2020, 08, 1, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, " ", am]).toString();
    selectedDate = task.taskDate;
    dateController.text = DateFormat.yMMMd().format(selectedDate);
    isRepeat = task.isRepeat;
  }

  // function to update task via bottomSheet
  updateTask(Task task) async {
    tempTask = Task();
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
    int index = allTasks.indexOf(task);
    allTasks.setAll(index, [tempTask]);
    taskRoutine();
    reWriteTasks();
    update([1, true]);
    Get.back();
    print(index);
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
  deleteTask(Task task) async {
    int index = allTasks.indexOf(task);
    allTasks.removeAt(index);
    taskRoutine();
    reWriteTasks();
    update([1, true]);
    print(index);
  }

  // function to rewrite all tasks to DB
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

  // function to reset all controllers
  controllerReset() {
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
    isRepeat = false;
  }

  // function to do routine on CRUD operations
  taskRoutine() {
    sortAllTasks();
    dailyTask();
    setCurrentTask();
    setUpcomingTask();
    cancellAllTaskNotification();
    setTaskNotification();
  }

  // setDateFunction bottomSheet
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

  // setTimeFunction bottomSheet
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

  // function to set currentTask
  setCurrentTask() {
    var cDt = DateTime.now();
    isCurrentTaskPresent = false;
    if (todayTasks.length != 0) {
      todayTasks.forEach((element) {
        if (element.taskDate.compareTo(cDt) <= 0) {
          currentTask = element;
          isCurrentTaskPresent = true;
        } else {}
        update([3, true]);
      });
    }
  }

  // function to set upcomingTask
  setUpcomingTask() {
    isUpcommingTaskPresent = false;
    upcomingTask = Task();
    var cDt = DateTime.now();
    if (todayTasks.length != 0) {
      for (int i = 0; i < todayTasks.length; i++) {
        if (todayTasks[i].taskDate.compareTo(cDt) > 0) {
          if (isCurrentTaskPresent) {
            var index = todayTasks.indexOf(currentTask);
            upcomingTask = todayTasks.elementAt(index + 1);
          } else {
            upcomingTask = todayTasks.first;
          }
          isUpcommingTaskPresent = true;
          break;
        }
      }
    }
    update([3, true]);
  }

  // function to get current user
  getUser() {
    userName = userData.read('fName');
    isMale = userData.read('isMale');
    update([7, true]);
  }

  // function to set notifications for tasks.
  setTaskNotification() {
    allTasks.forEach((element) {
      if (element.taskDate.isAfter(DateTime.now())) {
        nPlugin.showTaskNotification(element, allTasks.indexOf(element));
      }
    });
  }

  // function to cancel notifications for tasks.
  cancellAllTaskNotification() {
    allTasks.forEach((element) {
      nPlugin.cancelTaskNotifucation(allTasks.indexOf(element));
    });
  }

  @override
  void onInit() async {
    super.onInit();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    nPlugin = NotificationPlugin();
    allTasks = await getTasks();
    taskRoutine();
    reWriteTasks();
    update([1, true]);
    titleController = TextEditingController();
    descController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    slideC = SlidableController();
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
    super.onClose();
    titleController.dispose();
    descController.dispose();
    dateController.dispose();
    timeController.dispose();
  }

  // function to delete confirm dialog
  Future<dynamic> customDialogDel(BuildContext context, Task task) {
    return Get.dialog(Container(
      margin: EdgeInsets.symmetric(
          vertical: Get.height * 0.35, horizontal: Get.width * 0.18),
      padding: EdgeInsets.all(20),
      width: Get.width * 0.8,
      height: Get.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Delete Task!',
                  style: kSubHeadTextStyle.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Are you sure?',
                  style: kSubHeadTextStyle.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 140,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                'No',
                                style: kSubHeadTextStyle.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            slideC.activeState?.close();
                            Slidable.of(context)?.close();
                            deleteTask(task);
                            Get.back();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                'Yes',
                                style: kSubHeadTextStyle.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              )),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
