import 'package:erp/Model/Task_model/staff_list_model.dart';
import 'package:erp/provider/Task/staff_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_textfields.dart';

class AddNewStaff extends StatefulWidget {
  const AddNewStaff({super.key});

  @override
  State<AddNewStaff> createState() => _AddNewStaffState();
}

class _AddNewStaffState extends State<AddNewStaff> {
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
            children: [
               FloatingInputField(
                label: "Staff Name",
                hintText: "Enter full name",
                icon: Icons.person_outline,
                title: 'Staff Name',
                controller: staffNameController,
              ),
              const SizedBox(height: 12),
               FloatingInputField(
                label: "Address",
                hintText: "Enter address",
                icon: Icons.home_outlined,
                title: 'Staff Address',
                 controller: addressController,
              ),
              const SizedBox(height: 12),
               FloatingInputField(
                label: "Phone Number",
                hintText: "Enter phone number",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                title: 'Staff Phone',
                 controller: phoneController,
              ),
              const SizedBox(height: 12),
               FloatingInputField(
                label: "Mobile",
                hintText: "Enter mobile number",
                icon: Icons.smartphone_outlined,
                keyboardType: TextInputType.phone,
                title: 'Staff Mobile',
                 controller: mobileController,
              ),
              const SizedBox(height: 12),
               FloatingInputField(
                label: "Email",
                hintText: "Enter email address",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                title: 'Staff Email',
                 controller: emailController,
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
