class Task {
  String taskImage;
  String taskTitle;
  String taskDesc;
  bool isCompleted;
  String startTime;
  String endTime;
  String date;
  String repeat;

  Task({
    this.taskImage,
    this.taskTitle,
    this.taskDesc,
    this.startTime,
    this.endTime,
    this.date,
    this.repeat,
    this.isCompleted = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : taskImage = json['taskImage'],
        taskTitle = json['taskTitle'],
        taskDesc = json['taskDesc'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        date = json['date'],
        isCompleted = json['isCompleted'],
        repeat = json['repeat'];

  Map<String, dynamic> toJson() => {
        'taskImage': taskImage,
        'taskTitle': taskTitle,
        'taskDesc': taskDesc,
        'startTime': startTime,
        'endTime': endTime,
        'date': date,
        'isCompleted': isCompleted,
        'repeat': repeat,
      };

  void toggleComplete() {
    isCompleted = !isCompleted;
  }
}
