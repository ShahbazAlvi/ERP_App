

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../Model/Task_model/Task_list_model.dart';

class TaskListProvider with ChangeNotifier {
  List<TaskModel> _taskList = [];
  bool _isLoading = false;

  List<TaskModel> get taskList => _taskList;
  bool get isLoading => _isLoading;

  Future<void> getAssignStaff() async {
    _isLoading = true;
    notifyListeners();

    final String response = await rootBundle.loadString('assets/json/TaskList.json');

    final List data = json.decode(response);
    print(data);

    _taskList = data.map((e) => TaskModel.fromJson(e)).toList();

    _isLoading = false;
    notifyListeners();
  }
  void addTaskList(TaskModel tasklist) {
    _taskList.add(tasklist);
    notifyListeners();
  }
}
