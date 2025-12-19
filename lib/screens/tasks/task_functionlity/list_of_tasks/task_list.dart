import 'package:erp/screens/tasks/task_functionlity/list_of_staff/add_new_staff.dart';
import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<TaskListScreen> {
  TextEditingController searchController = TextEditingController();

  // Dummy staff data
  List<Map<String, String>> taskList = [
    {"task": "Ali Khan", "phone": "0301-1234567"},
    {"task": "Ahmed Raza", "phone": "0302-9876543"},
    {"task": "Sara Malik", "phone": "0303-4567890"},
    {"task": "Usman Shah", "phone": "0304-1122334"},
  ];

  List<Map<String, String>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = taskList;
  }

  void filterStaff(String query) {
    setState(() {
      filteredList = taskList
          .where(
            (staff) =>
        staff["task"]!.toLowerCase().contains(query.toLowerCase()) ||
            staff["phone"]!.contains(query),
      )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ===================== APP BAR =====================
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
            "Task List",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),

      // ===================== BODY =====================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== STAFF HEADER + ADD BUTTON =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Task",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to Add Staff Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddNewStaff()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
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

            // ===== SEARCH BAR =====
            TextField(
              controller: searchController,
              onChanged: filterStaff,
              decoration: InputDecoration(
                hintText: "Search task...",
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

            // ===== STAFF LIST =====
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final staff = filteredList[index];

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
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      // ===== NAME =====
                      title: Text(
                        staff["task"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // ===== PHONE =====
                      subtitle: Text(
                        staff["phone"]!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),

                      // ===== ACTION BUTTONS =====
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 28,
                            height: 20,
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
                              onPressed: () {
                                // Edit staff
                              },
                            ),
                          ),
                          SizedBox(width: 4),
                          const SizedBox(width: 0),
                          Container(
                            width: 28,
                            height: 20,
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
                              onPressed: () {
                                // Delete staff
                              },
                            ),
                          ),
                        ],
                      ),

                      // OPTIONAL: Tap whole tile
                      onTap: () {
                        // View staff details
                      },
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
}
