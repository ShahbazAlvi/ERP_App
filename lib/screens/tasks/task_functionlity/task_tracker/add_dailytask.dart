import 'package:erp/Model/Task_model/staff_list_model.dart';
import 'package:erp/provider/Task/staff_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_textfields.dart';
import '../../../../widgets/start_end_date_picker.dart';

class AddDailytask extends StatefulWidget {
  const AddDailytask({super.key});

  @override
  State<AddDailytask> createState() => _AddDailytaskState();
}

class _AddDailytaskState extends State<AddDailytask> {
  final List<String> customers = ["Ali Khan", "Sara Malik", "Usman Shah"];
  String? selectedCustomer;

  // Dummy products for each customer
  final Map<String, List<String>> customerProducts = {
    "Ali Khan": ["Website", "Mobile App", "ERP Module","ERP Module","ERP Module"],
    "Sara Malik": ["Ecommerce Site", "Landing Page",'graphic desghn'],
    "Usman Shah": ["Mobile App", "ERP Module", "Dashboard"],
  };String taskStatus = "In Progress";

  final List<String> tasks = [
    "Design",
    "Development",
    "Bug Fixing",
    "Deployment"
  ];String? selectedTask;
  TextEditingController taskDescriptionController = TextEditingController();
  Map<String, bool> selectedProducts = {};
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController staffNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
            "Add New Staff",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatingDateField(
                label: "Current Date",
                icon: Icons.date_range,
                controller: startDateController, title: 'Current Date',
              ),
              const SizedBox(height: 10),



// ---- TASK DROPDOWN -----
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Task",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
              ),

              DropdownButtonFormField<String>(
                value: selectedTask,
                items: tasks
                    .map(
                      (task) => DropdownMenuItem(
                    value: task,
                    child: Text(task),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTask = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Select Task",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

// ---- DESCRIPTION (ONLY WHEN TASK SELECTED) -----
              if (selectedTask != null) ...[
                const SizedBox(height: 10),

                FloatingInputField(

                  hintText: "Task Description ",
                  // icon: Icons.confirmation_number,
                  title: 'Description',
                  maxLines: 3,
                ),
              ],
              FloatingDateField(
                label: "Start Date",
                icon: Icons.date_range,
                controller: startDateController, title: 'Start Date',
              ),
              FloatingDateField(
                label: "End Date",
                icon: Icons.date_range,
                controller: endDateController, title: 'End Date',
              ),
// ---- STATUS RADIO BUTTONS -----
              const SizedBox(height: 10),
              Text(
                "Task Status",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.blue,
                        value: "In Progress",
                        groupValue: taskStatus,
                        onChanged: (value) {
                          setState(() => taskStatus = value!);
                        },
                      ),
                      const Text("In Progress"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.blue,
                        value: "Completed",
                        groupValue: taskStatus,
                        onChanged: (value) {
                          setState(() => taskStatus = value!);
                        },
                      ),
                      const Text("Completed"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.blue,
                        value: "On Hold",
                        groupValue: taskStatus,
                        onChanged: (value) {
                          setState(() => taskStatus = value!);
                        },
                      ),
                      const Text("On Hold"),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: CustomElevatedButton(
                  text: "Add Staff",
                  icon: Icons.add,
                  color: Color(0xFF42A5F5),
                  onPressed: () {
                    final provider=Provider.of<StaffProvider>(context,listen: false);
                    final newStaff = StaffListModel(
                        staffId: "staff00${provider.staffList.length + 1}",
                        staffName: staffNameController.text,
                        staffAddress: addressController.text,
                        staffPhone: phoneController.text,
                        staffEmail: emailController.text);
                    provider.addStaff(newStaff); // 🔥 UI auto update
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
