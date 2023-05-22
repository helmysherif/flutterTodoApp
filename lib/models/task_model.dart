class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool status;
  String userId;
  int dateOfTime;

  TaskModel(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      required this.status,
      required this.userId,
      required this.dateOfTime});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            description: json['description'],
            date: json['date'],
            status: json['status'],
            id: json['id'],
            userId: json['userId'],
            dateOfTime: json['dateOfTime']);

  // TaskModel fromJson(Map<String , dynamic> json)
  // {
  //   TaskModel taskModel = TaskModel(
  //     title: json['title'],
  //     description: json['description'],
  //     date: json['date'],
  //     status: json['status'],
  //     id : json['id']
  //   );
  //   return taskModel;
  // }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "status": status,
      "userId": userId,
      "dateOfTime": dateOfTime
    };
  }
}
