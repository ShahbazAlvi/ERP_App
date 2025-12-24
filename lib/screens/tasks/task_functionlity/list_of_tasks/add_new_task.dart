import 'package:erp/provider/Task/TaskListProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Model/Task_model/Task_list_model.dart';
import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_textfields.dart';
import '../../../../widgets/start_end_date_picker.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDetailController = TextEditingController();
  TextEditingController resourcesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Add New Task",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
               FloatingInputField(
                hintText: "Enter Task name ",
                icon: Icons.task_outlined,
                title: 'Task Name',
                controller: taskNameController,
              ),
              FloatingInputField(
                label: "Task Details",
                hintText: "Enter Task Details",
                controller: taskDetailController,
                title: 'Task Details',
                maxLines: 3,
              ), const SizedBox(height: 12),
              FloatingDateField(
                label: "Start Date",
                icon: Icons.date_range,
                controller: startDateController, title: 'Start Date',
              ),
              const SizedBox(height: 12),
              FloatingDateField(
                label: "End Date",
                icon: Icons.date_range,
                controller: endDateController, title: 'End Date',
              ),FloatingInputField(
                label: "Resources",
                hintText: "Enter Task name ",
                icon: Icons.task_outlined,
                title: 'No.of Resources(required)',
                controller: resourcesController,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: CustomElevatedButton(
                  text: "Add New Task",
                  icon: Icons.add,
                  color: Color(0xFF42A5F5),

                    onPressed: () {
                      final provider=Provider.of<TaskListProvider>(context,listen: false);
                      final newTaskList = TaskModel(
                          taskId: "task00${provider.taskList.length + 1}",
                          task: taskNameController.text,
                          taskDetail: taskDetailController.text,
                          startDate: startDateController.text,
                          endDate: endDateController.text,
                          resources: resourcesController.text);
                      provider.addTaskList(newTaskList); // 🔥 UI auto update
                      Navigator.pop(context);
                    },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
