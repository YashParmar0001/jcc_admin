import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcc_admin/common/widget/scroll_to_hide_widget.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/features/complaint/widgets/complaints_overview.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({
    super.key,
    required this.controller,
    required this.bottomNavKey,
  });

  final ScrollController controller;
  final GlobalKey<ScrollToHideWidgetState> bottomNavKey;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ComplaintScreen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ComplaintsOverview(),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.brilliantAzure,
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(5),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.darkMidnightBlue,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'Pending',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Taken',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              TabBarView(children: [
                Text('Tab 1'),
                Text('Tab 2'),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
