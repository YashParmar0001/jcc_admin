// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jcc_admin/generated/assets.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmployeeDetails'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text("Edit"),
                ),
                const PopupMenuItem(
                  child: Text("Delete"),
                ),
              ];
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/department/water.png",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Image.asset(
                    Assets.iconsLogo,
                    width: double.infinity,
                  ),
                  _buildEmployDataField(
                      title: "Full name ", data: "Bhavy Ukani"),
                  _buildEmployDataField(
                      title: "Employee ID", data: "EMP465432"),
                  _buildEmployDataField(
                      title: "Mobile No", data: "+91 63555 77329"),
                  _buildEmployDataField(
                      title: "Email", data: "bhavycnt@gmail.com"),
                  _buildEmployDataField(title: "Department", data: "Coding"),
                  _buildEmployDataField(title: "Post", data: "Pro Dev"),
                  _buildEmployDataField(
                      title: "Ward no", data: "Khud ka Ilaqa"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmployDataField({required String title, required String data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
