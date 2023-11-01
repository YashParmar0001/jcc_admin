import 'package:flutter/material.dart';
import 'package:jcc_admin/common/widget/scroll_to_hide_widget.dart';
import 'package:jcc_admin/features/notification/widget/notification_widget.dart';
import 'package:jcc_admin/model/notification_model.dart';

import '../../../constants/app_color.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({
    Key? key,
    required this.controller,
    required this.bottomNavKey,
  }) : super(key: key);

  final ScrollController controller;
  final GlobalKey<ScrollToHideWidgetState> bottomNavKey;

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
