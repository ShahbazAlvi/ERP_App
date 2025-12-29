import 'package:flutter/material.dart';
import 'add_complaint_tostaff.dart';

class StaffComplaintsList extends StatefulWidget {
  const StaffComplaintsList({super.key});

  @override
  State<StaffComplaintsList> createState() => _StaffComplaintsListState();
}

class _StaffComplaintsListState extends State<StaffComplaintsList> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> complaintList = [
    {
      "id": "Complaint001",
      "customer": "Ali Khan",
      "products": ["Website", "Mobile App", "ERP Module"],
      "date": "2025-12-22",
      "assign": "Assign001"
    },
    {
      "id": "Complaint002",
      "customer": "Ali",
      "products": ["Mobile App"],
      "date": "2025-12-21",
      "assign": "Assign002"
    },
    {
      "id": "Complaint003",
      "customer": "Usman",
      "products": ["Mobile App", "Odoo ERP"],
      "date": "2025-12-20",
      "assign": "Assign003"
    },
  ];

  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = complaintList;
  }

  void filterComplaints(String query) {
    setState(() {
      filteredList = complaintList
          .where((c) =>
      c["id"].toLowerCase().contains(query.toLowerCase()) ||
          c["customer"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.12),
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
            icon: Icon(Icons.arrow_back,
                color: Colors.white, size: width * 0.065),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Assign Complaints to Staff List",
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(width * 0.04),

        child: Column(
          children: [
            // Header + Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Assign Complaints",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const AddComplaintsTostaff(),
                      ),
                    );
                  },
                  icon: Icon(Icons.add, size: width * 0.05),
                  label: Text(
                    "Add New",
                    style: TextStyle(fontSize: width * 0.04),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: height * 0.015),

            // Search Field
            TextField(
              controller: searchController,
              onChanged: filterComplaints,
              decoration: InputDecoration(
                hintText: "Search by ID or Customer...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            // LIST
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final complaint = filteredList[index];
                  final products =
                  (complaint["products"] as List<dynamic>).toList();

                  return Container(
                    margin: EdgeInsets.only(bottom: height * 0.015),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: EdgeInsets.all(width * 0.04),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date + Assign
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                complaint["date"],
                                style: TextStyle(
                                  fontSize: width * 0.032,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                complaint["assign"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.035,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: height * 0.01),

                          // ID + Name + Actions
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${complaint["id"]} - ${complaint["customer"]}",
                                  style: TextStyle(
                                    fontSize: width * 0.042,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  _iconButton(
                                    color: Colors.blue.shade100,
                                    icon: Icons.edit,
                                    iconColor: Colors.blue,
                                    onTap: () {},
                                  ),
                                  SizedBox(width: width * 0.02),
                                  _iconButton(
                                    color: Colors.red.shade100,
                                    icon: Icons.delete,
                                    iconColor: Colors.red,
                                    onTap: () {},
                                  ),
                                ],
                              )
                            ],
                          ),

                          SizedBox(height: height * 0.01),

                          // Products tags
                          Wrap(
                            spacing: width * 0.02,
                            children: products
                                .map(
                                  (p) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: height * 0.008,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  p.toString(),
                                  style: TextStyle(fontSize: width * 0.032),
                                ),
                              ),
                            )
                                .toList(),
                          )
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

  // Small reusable icon button
  Widget _iconButton({
    required Color color,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: iconColor, size: 18),
        onPressed: onTap,
      ),
    );
  }
}
