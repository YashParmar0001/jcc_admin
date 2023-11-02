import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:jcc_admin/common/widget/scroll_to_hide_widget.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/features/complaint/widgets/complaints_overview.dart';
import 'package:jcc_admin/features/complaint/widgets/complaint_widget.dart';
import 'package:jcc_admin/model/complaint_model.dart';

import '../../../bloc/complaint/complaint_bloc.dart';

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
          actions: [
            IconButton(
                onPressed: () {
                  debugDumpRenderTree();
                },
                icon: Icon(Icons.sort))
          ],
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
              // TabBarView(children: [
              //   Text('Tab 1'),
              //   Text('Tab 2'),
              // ]),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: BlocBuilder<ComplaintBloc, ComplaintState>(
                  builder: (context, state) {
                    if (state is ComplaintLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ComplaintLoaded) {
                      final id = (context.read<LoginBloc>().state as LoggedIn)
                          .employee
                          .employeeId;
                      final takenList = state.complaintList.where((complaint) =>
                          complaint.isAssigned &&
                          complaint.assignedEmployeeId == id).toList();

                      return TabBarView(
                        children: [
                          buildList(state.complaintList),
                          buildList(takenList),
                        ],
                      );
                    }

                    return TabBarView(
                      children: [
                        buildList([]),
                        buildList([]),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(List<ComplaintModel> list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ComplaintWidget(
          complaint: list[index],
        );
      },
      itemCount: list.length,

      // shrinkWrap: true,
    );
  }
}
