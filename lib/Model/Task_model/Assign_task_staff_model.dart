// class AssignTaskStaffModel {
//   final String assignid;
//   final String task;
//   final String staff;
//
//   AssignTaskStaffModel({
//     required this.assignid,
//     required this.task,
//     required this.staff,
//   });
//
//   factory AssignTaskStaffModel.fromJson(Map<String, dynamic> json) {
//     return AssignTaskStaffModel(
//       assignid: json['assignid'] ?? '',
//       task: json['task'] ?? json['name'] ?? '',
//       staff: json['staff'] ?? json['price'] ?? '',
//     );
//   }
// }
class AssignTaskStaffModel {
  final String assignid;
  final String task;
  final String staff;

  // 🔹 New fields (optional)
  final String startDate;
  final String endDate;
  final String customer;
  final String department;

  AssignTaskStaffModel({
    required this.assignid,
    required this.task,
    required this.staff,
    this.startDate = '',
    this.endDate = '',
    this.customer = '',
    this.department = '',
  });

  factory AssignTaskStaffModel.fromJson(Map<String, dynamic> json) {
    return AssignTaskStaffModel(
      assignid: json['assignid'] ?? '',
      task: json['task'] ?? json['name'] ?? '',
      staff: json['staff'] ?? json['price'] ?? '',

      // 🔹 New JSON keys
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      customer: json['customer'] ?? '',
      department: json['department'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "assignid": assignid,
      "task": task,
      "staff": staff,
      "start_date": startDate,
      "end_date": endDate,
      "customer": customer,
      "department": department,
    };
  }
}
