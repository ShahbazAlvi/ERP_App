class AssignTaskStaffModel {
  final String assignid;
  final String task;
  final String dist;

  AssignTaskStaffModel({
    required this.assignid,
    required this.task,
    required this.dist,
  });

  factory AssignTaskStaffModel.fromJson(Map<String, dynamic> json) {
    return AssignTaskStaffModel(
      assignid: json['assignid'] ?? '',
      task: json['task'] ?? json['name'] ?? '',
      dist: json['dist'] ?? json['price'] ?? '',
    );
  }
}
