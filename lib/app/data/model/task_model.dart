class Task {
  String taskImage;
  String taskTitle;
  String taskDesc;
  DateTime startTime;
  DateTime endTime;
  String repeat;

  Task({
    this.taskImage,
    this.taskTitle,
    this.taskDesc,
    this.startTime,
    this.endTime,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json)
      : taskImage = json['taskImage'],
        taskTitle = json['taskTitle'],
        taskDesc = json['taskDesc'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        repeat = json['repeat'];

  Map<String, dynamic> toJson() => {
        'taskImage': taskImage,
        'taskTitle': taskTitle,
        'taskDesc': taskDesc,
        'startTime': startTime,
        'endTime': endTime,
        'repeat': repeat,
      };
}
