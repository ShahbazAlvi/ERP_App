class TaskModel {
  final String taskId;
  final String task;
  final String taskDetail;
  final String startDate;
  final String endDate;
  final String resources;

  TaskModel({
    required this.taskId,
    required this.task,
    required this.taskDetail,
    required this.startDate,
    required this.endDate,
    required this.resources,
  });

  // JSON -> Model
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['task_id'] ?? '',
      task: json['task'] ?? '',
      taskDetail: json['task_detail'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      resources: json['resources'] ?? '',
    );
  }

  // Model -> JSON
  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'task': task,
      'task_detail': taskDetail,
      'start_date': startDate,
      'end_date': endDate,
      'resources': resources,
    };
  }
}
