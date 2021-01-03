class Task {
  String taskImage;
  String taskTitle;
  String taskDesc;
  bool isCompleted;
  String startTime;
  String endTime;
  String date;

  Task({
    this.taskImage,
    this.taskTitle,
    this.taskDesc,
    this.startTime,
    this.endTime,
    this.date,
    this.isCompleted = false,
  });
  void toggleComplete() {
    isCompleted = !isCompleted;
  }
}
