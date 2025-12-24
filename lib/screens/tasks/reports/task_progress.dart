import 'package:flutter/material.dart';

class TaskProgress extends StatefulWidget {
  const TaskProgress({super.key});

  @override
  State<TaskProgress> createState() => _TaskProgressState();
}

class _TaskProgressState extends State<TaskProgress> {
  TextEditingController searchController = TextEditingController();
  String selectedFilter = "All";

  // Sample task data
  List<Map<String, dynamic>> taskList = [
    {
      "assigned": "ASSIGN001",
      "assignment": "Mobile App Development",
      "task_detail": "Developing a cross-platform mobile application for Client X including UI, frontend, and backend functionality. Integration with API and testing included.",
      "tasks": ["UI Design", "Frontend Development", "Backend Development", "API Integration", "Unit Testing"],
      "status": "In Progress",
      "priority": "High",
      "progress_percentage": 45,
      "start_date": "2025-01-10",
      "end_date": "2025-02-15"
    },
    {
      "assigned": "ASSIGN002",
      "assignment": "Corporate Website Redesign",
      "task_detail": "Redesigning the corporate website for Client Y with responsive UI, improved UX, and SEO optimization.",
      "tasks": ["Wireframe Design", "UI/UX Design", "Frontend Implementation", "SEO Optimization", "QA Testing"],
      "status": "Complete",
      "priority": "Medium",
      "progress_percentage": 100,
      "start_date": "2025-01-05",
      "end_date": "2025-01-25"
    },
    {
      "assigned": "ASSIGN003",
      "assignment": "ERP Module Implementation",
      "task_detail": "Implementing ERP module for inventory and finance management for Client Z. Database setup, API integration, and user interface configuration included.",
      "tasks": ["Database Setup", "API Integration", "UI Configuration", "Testing & Deployment"],
      "status": "In Progress",
      "priority": "High",
      "progress_percentage": 60,
      "start_date": "2025-01-12",
      "end_date": "2025-03-01"
    },
    {
      "assigned": "ASSIGN004",
      "assignment": "Delivery Management System",
      "task_detail": "Building a delivery tracking system with route optimization and automated notifications for client logistics operations.",
      "tasks": ["Routing Algorithm", "Backend API", "Notification System", "Frontend Dashboard"],
      "status": "In Progress",
      "priority": "Medium",
      "progress_percentage": 30,
      "start_date": "2025-01-15",
      "end_date": "2025-03-10"
    },
    {
      "assigned": "ASSIGN005",
      "assignment": "Customer Support Automation",
      "task_detail": "Implementing automated chat support and ticketing system to improve client customer service operations.",
      "tasks": ["Chat UI Development", "Backend Logic", "Ticketing System", "Notification Integration"],
      "status": "Complete",
      "priority": "Low",
      "progress_percentage": 100,
      "start_date": "2025-01-08",
      "end_date": "2025-02-01"
    }
  ];


  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = taskList;
  }

  void filterTasks(String query) {
    setState(() {
      filteredList = taskList.where((task) {
        final matchesSearch = task["assigned"]
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()) ||
            task["assignment"]
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
        final matchesFilter = selectedFilter == "All" ||
            task["status"] == selectedFilter;
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      filterTasks(searchController.text);
    });
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
            "Tasks Progress",
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
            // Search Bar
            TextField(
              controller: searchController,
              onChanged: filterTasks,
              decoration: InputDecoration(
                hintText: "Search tasks...",
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

            // Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["All", "In Progress", "Complete"].map((filter) {
                bool isSelected = selectedFilter == filter;
                return ElevatedButton(
                  onPressed: () => setFilter(filter),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isSelected ? Colors.blue : Colors.grey.shade200,
                    foregroundColor:
                    isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(filter),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final task = filteredList[index];
                  return GestureDetector(
                    onTap: () {
                      // 🔹 Show all task details regardless of status
                      showTaskDetailDialog(context, task);
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Assigned Staff
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  task["assignment"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Icon(
                                  task["status"] == "Complete"
                                      ? Icons.check_circle
                                      : Icons.timelapse,
                                  color: task["status"] == "Complete"
                                      ? Colors.green
                                      : Colors.orange,
                                )
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Assignment Name

                            // Task list
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (task["tasks"] as List<String>)
                                  .map((t) => Row(
                                children: [
                                  const Icon(Icons.circle,
                                      size: 6, color: Colors.black54),
                                  const SizedBox(width: 6),
                                  Text(t),
                                ],
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showTaskDetailDialog(BuildContext context, Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("${task["assignment"]} Details", style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow("Assigned ID", task["assigned"]),
                _detailRow("Status", task["status"]),
                _detailRow("Priority", task["priority"] ?? "-"),
                _detailRow("Start Date", task["start_date"] ?? "-"),
                _detailRow("End Date", task["end_date"] ?? "-"),
                const SizedBox(height: 8),
                const Text("Task Description:", style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(task["task_detail"] ?? "-"),
                ),
                const SizedBox(height: 8),
                const Text("Subtasks:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...((task["tasks"] as List<String>).map((t) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text("- $t"),
                ))),
                const SizedBox(height: 12),
                const Text("Progress:", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: (task["progress_percentage"] ?? 0) / 100,
                  color: task["status"] == "Complete" ? Colors.green : Colors.orange,
                  backgroundColor: Colors.grey.shade300,
                  minHeight: 10,
                ),
                const SizedBox(height: 4),
                Text("${task["progress_percentage"] ?? 0}%", style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value.isEmpty ? "-" : value)),
        ],
      ),
    );
  }


}
