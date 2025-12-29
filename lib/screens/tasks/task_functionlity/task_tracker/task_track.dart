import 'package:erp/screens/tasks/task_functionlity/task_tracker/add_dailytask.dart';
import 'package:flutter/material.dart';

class TaskTrackerScreen extends StatefulWidget {
  const TaskTrackerScreen({super.key});

  @override
  State<TaskTrackerScreen> createState() => _TaskTrackerScreenState();
}

class _TaskTrackerScreenState extends State<TaskTrackerScreen> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> taskList = [
    {
      "id": "Task001",
      "project": "ERP Module",
      "assigned": "Staff001",
      "status": "In Progress",
      "date": "2025-12-22"
    },
    {
      "id": "Task002",
      "project": "Mobile App",
      "assigned": "Staff002",
      "status": "On Hold",
      "date": "2025-12-21"
    },
    {
      "id": "Task003",
      "project": "Website",
      "assigned": "Staff003",
      "status": "Complete",
      "date": "2025-12-20"
    },
  ];

  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = taskList;
  }

  void filterTasks(String query) {
    setState(() {
      filteredList = taskList
          .where((task) =>
      task["project"]
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()) ||
          task["id"]
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "in progress":
        return Colors.orange.shade300;
      case "on hold":
        return Colors.red.shade300;
      case "complete":
        return Colors.green.shade300;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
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
            "Task Tracker",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tasks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDailytask(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Daily Task"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF1976D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            TextField(
              controller: searchController,
              onChanged: filterTasks,
              decoration: InputDecoration(
                hintText: "Search by Project...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final task = filteredList[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 PROJECT + EDIT / DELETE (same row)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                task["project"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Row(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blue.shade100,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 18,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red.shade100,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// 🔹 DATE + STATUS (under the row)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                task["date"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: getStatusColor(task["status"]),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  task["status"],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
