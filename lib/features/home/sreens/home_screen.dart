// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/features/home/widget/drawer_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                _buildCardItem(
                  context: context,
                  title: "Registerd",
                  percentage: "60 %",
                  count: "2597935798",
                  lable: "Complaint Registerd",
                  bgColor: Color(0xFF15DCE8),
                  progressColor: Color(0xFF00AAF2),
                ),
                _buildCardItem(
                  context: context,
                  title: "On Hold",
                  percentage: "60 %",
                  count: "2597935798",
                  lable: "Complaint Registerd",
                  bgColor: Color(0xFFFF9999),
                  progressColor: Color(0xFFFF1F1F),
                ),
              ],
            ),
            Row(
              children: [
                _buildCardItem(
                  context: context,
                  title: "In Process",
                  percentage: "60 %",
                  count: "2597935798",
                  lable: "Complaint Registerd",
                  bgColor: Color(0xFFBF57FF),
                  progressColor: Color(0xFF9E07A1),
                ),
                _buildCardItem(
                  context: context,
                  title: "Completed",
                  percentage: "60 %",
                  count: "2597935798",
                  lable: "Complaint Registerd",
                  bgColor: Color(0xFF66CC66),
                  progressColor: Color(0xFF008905),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: MediaQuery.of(context).size.width-100,
              child: PieChart(
                swapAnimationDuration: Duration(milliseconds: 500),
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.red,
                      value: 60,
                      title: "60%",
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 60,
                      title: "30%",
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: 60,
                      title: "20%",
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.yellow,
                      value: 60,
                      title: "10%",
                      radius: 50,
                      titleStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem({
    required BuildContext context,
    required String title,
    required String percentage,
    required String count,
    required String lable,
    required Color bgColor,
    required Color progressColor,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 140,
        width: (MediaQuery.of(context).size.width / 2) - 8,
        child: Stack(
          children: [
            Container(
              color: bgColor,
              height: 70,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 0,
              child: Container(
                color: Colors.white,
                height: 70,
                width: (MediaQuery.of(context).size.width / 2) - 8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        count,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        lable,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: bgColor,
                ),
                width: 30,
                height: 30,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      value: 0.5,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),
                    Text(
                      "60",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
