class Task {
  String taskImage;
  String taskTitle;
  String taskDesc;
  DateTime startTime;

  Task({
    this.taskImage,
    this.taskTitle,
    this.taskDesc,
    this.startTime,
  });

  Task.fromJson(Map<String, dynamic> json)
      : taskImage = json['taskImage'],
        taskTitle = json['taskTitle'],
        taskDesc = json['taskDesc'],
        startTime = json['startTime'];

  Map<String, dynamic> toJson() => {
        'taskImage': taskImage,
        'taskTitle': taskTitle,
        'taskDesc': taskDesc,
        'startTime': startTime,
      };
}
