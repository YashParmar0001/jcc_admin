import 'package:flutter/material.dart';
import 'package:jcc_admin/features/notification/widget/notification_widget.dart';
import 'package:jcc_admin/model/notification_model.dart';

import '../../../constants/app_color.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmployeeScreen'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.darkMidnightBlue,
        onPressed: () {
          context.push('/newEmployee');
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          "Add Employees",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: notificationData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                context.push('/employeeDetails');
              },
              child: NotificationWidget(
                notificationModel: notificationData[index],
              ));
        },
      ),
    );
  }
}
