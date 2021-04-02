class Task {
  String taskImage;
  String taskTitle;
  String taskDesc;
  String startTime;
  String taskDate;

  Task({
    this.taskImage,
    this.taskTitle,
    this.taskDesc,
    this.startTime,
    this.taskDate,
  });

  Task.fromJson(Map<String, dynamic> json)
      : taskImage = json['taskImage'],
        taskTitle = json['taskTitle'],
        taskDesc = json['taskDesc'],
        startTime = json['startTime'],
        taskDate = json['taskDate'];

  Map<String, dynamic> toJson() => {
        'taskImage': taskImage,
        'taskTitle': taskTitle,
        'taskDesc': taskDesc,
        'startTime': startTime,
        'taskDate': taskDate,
      };
}
