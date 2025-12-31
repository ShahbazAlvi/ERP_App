import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erp/screens/complaints/complaints.dart';
import 'package:erp/screens/hrm/hrmdashboard.dart';
import 'package:erp/screens/production/production.dart';
import 'package:erp/screens/purchase/purchase_dashboard.dart';
import 'package:erp/screens/sales/sales.dart';
import 'package:erp/screens/stock/stock.dart';
import 'package:erp/screens/tasks/tasksdash.dart';
import 'package:erp/widgets/erpcards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
final List<Color> _SummaryColors = [
  Colors.green.shade300,
  Colors.blue.shade900,
  Colors.orange.shade300,
  Colors.purple.shade300,

  Colors.red.shade300,
  Colors.teal.shade300,
  Colors.indigo.shade300,
  Colors.pink.shade300,
];
class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> summaryList = [
    {'title': "Today's Sales", 'value': "Rs 45,000", 'icon': Icons.trending_up, 'change': 5},
    {'title': "Low Stock", 'value': "12 Items", 'icon': Icons.warning_amber, 'change': -2},
    {'title': "Pending Tasks", 'value': "8", 'icon': Icons.task_alt, 'change': 3},
    {'title': " Orders", 'value': "15", 'icon': Icons.shopping_cart, 'change': 7},
  ];
  int _currentindex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int summaryColumns = (screenWidth ~/ 120).clamp(1, 2);
    int moduleColumns = (screenWidth ~/ 100).clamp(2, 4);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ===================== APP BAR =====================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent, // gradient replaces color
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
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi ABCD 👋",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Enterprise Resource Planning  ",
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            IconButton(
              icon: const Icon(
                Icons.calendar_today_outlined,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),

      // ===================== BODY =====================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== HEADING =====
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                "Today’s Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

// ===== SUMMARY CARDS =====
            GridView.builder(
              itemCount: summaryList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: summaryColumns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                return summaryCard(
                  title: summaryList[index]['title'],
                  value: summaryList[index]['value'],
                  icon: summaryList[index]['icon'],
                  index: index,
                );
              },
            ),



            const SizedBox(height: 0),
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                "Modules",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // ===== ERP MODULES =====
            GridView.count(
              crossAxisCount: moduleColumns,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.9,
              shrinkWrap: true, // important
              physics:
                  const NeverScrollableScrollPhysics(), // disable GridView scroll
              children: [
                ErpCard(
                  title: "Stock",
                  icon: Icons.inventory_2,
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Stockscreen()),
                    );
                  },
                ),
                ErpCard(
                  title: "Purchases",
                  icon: Icons.shopping_cart,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PurchaseDashboard(),
                      ),
                    );
                  },
                ),
                ErpCard(
                  title: "Sales",
                  icon: Icons.point_of_sale,
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sales()),
                    );
                  },
                ),
                ErpCard(
                  title: "Production",
                  icon: Icons.factory,
                  color: Colors.purple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Production()),
                    );
                  },
                ),
                ErpCard(
                  title: "Complaints",
                  icon: Icons.report_problem,
                  color: Colors.red,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Complaints()),
                    );
                  },
                ),
                // ErpCard(
                //   title: "Contacts",
                //   icon: Icons.contacts,
                //   color: Colors.teal,
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => Contactsdash()),
                //     );
                //   },
                // ),
                ErpCard(
                  title: "Tasks",
                  icon: Icons.task,
                  color: Colors.indigo,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tasksdashboard()),
                    );
                  },
                ),
                ErpCard(
                  title: "HRM",
                  icon: Icons.people,
                  color: Colors.brown,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Hrmdashboard()),
                    );
                  },
                ),
                ErpCard(
                  title: "Financial",
                  icon: Icons.account_balance,
                  color: Colors.deepOrange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Production()),
                    );
                  },
                ),
                ErpCard(
                  title: "Security",
                  icon: Icons.security,
                  color: Colors.deepPurple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Production()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),

      // ===================== CURVED NAV BAR =====================
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentindex,
        height: 70,
        color: Colors.blueAccent, // navbar color
        backgroundColor: Colors.transparent, // remove bg
        animationDuration: const Duration(milliseconds: 600),
        items: const [
          Icon(Icons.dashboard_outlined, color: Colors.white, size: 30),
          Icon(CupertinoIcons.shopping_cart, color: Colors.white, size: 30),
          Icon(CupertinoIcons.chat_bubble_text, color: Colors.white, size: 30),
          Icon(Icons.person_outline_outlined, color: Colors.white, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
      extendBody: true,
    );
  }

  // ===================== SUMMARY CARD =====================
  Widget summaryCard({
    required String title,
    required String value,
    required IconData icon,
    int? index,
  }) {
    // Pick color from SummaryColors
    Color color = index != null
        ? _SummaryColors[index % _SummaryColors.length]
        : _SummaryColors[Random().nextInt(_SummaryColors.length)];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ICON + TITLE
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.25),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),

          // VALUE
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }

}
