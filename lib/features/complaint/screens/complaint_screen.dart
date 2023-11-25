import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:jcc_admin/common/widget/menu_drawer.dart';
import 'package:jcc_admin/common/widget/scroll_to_hide_widget.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/features/complaint/widgets/complaints_overview.dart';
import 'package:jcc_admin/features/complaint/widgets/complaint_widget.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/model/complaint_model.dart';
import 'dart:developer' as dev;
import '../../../bloc/complaint/complaint_bloc.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({
    super.key,
    required this.controller,
    required this.bottomNavKey,
  });

  final ScrollController controller;
  final GlobalKey<ScrollToHideWidgetState> bottomNavKey;

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    final type = (context.read<LoginBloc>().state as LoggedIn).employee.type;

    return DefaultTabController(
      length: (type == 'hod') ? 5 : 3,
      child: Scaffold(
        drawer: const MenuDrawer(),
        onDrawerChanged: (isOpened) {
          if (isOpened) {
            if (widget.bottomNavKey.currentState != null) {
              dev.log('State is not null', name: 'Complaint Screen');
              if (widget.bottomNavKey.currentState!.isVisible) {
                widget.bottomNavKey.currentState!.hide();
              }
            } else {
              dev.log('State is null', name: 'Complaint Screen');
            }
          } else {
            if (widget.bottomNavKey.currentState != null) {
              dev.log('State is not null', name: 'Complaint Screen');
              if (!widget.bottomNavKey.currentState!.isVisible) {
                widget.bottomNavKey.currentState!.show();
              }
            } else {
              dev.log('State is null', name: 'Complaint Screen');
            }
          }
        },
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: SvgPicture.asset(
                  Assets.iconsMenu,
                  fit: BoxFit.cover,
                )),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(Assets.iconsFilter),
            ),
          ],
          centerTitle: true,
          title: Text(
            'Complaints',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 22,
                ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ComplaintsOverview(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 50,
                  // width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.brilliantAzure,
                  ),
                  child: TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.all(5),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.darkMidnightBlue,
                    ),
                    tabs: buildListTabs(type: type),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<ComplaintBloc, ComplaintState>(
                builder: (context, state) {
                  if (state is ComplaintLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ComplaintError) {
                    return Text(state.message);
                  } else if (state is ComplaintLoaded) {
                    final employee =
                        (context.read<LoginBloc>().state as LoggedIn).employee;
                    final id = employee.employeeId;

                    if (employee.type == 'employee') {
                      final complaintList = state.complaintList
                          .where((complaint) => complaint.ward == employee.ward)
                          .toList();

                      final pending = complaintList
                          .where((complaint) =>
                              complaint.status == "Registered" &&
                              !complaint.isAssigned)
                          .toList();

                      final taken = complaintList
                          .where((complaint) =>
                              complaint.status != 'Solved' &&
                              complaint.isAssigned &&
                              complaint.assignedEmployeeId == id)
                          .toList();

                      final solved = complaintList
                          .where((complaint) =>
                              complaint.status == 'Solved' &&
                              complaint.assignedEmployeeId == id)
                          .toList();

                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 355,
                        child: TabBarView(
                          children: [
                            buildList(
                              context,
                              pending,
                              widget.controller,
                              'No registered complaints in your ward!',
                            ),
                            buildList(
                              context,
                              taken,
                              widget.controller,
                              'You have no complaints working or with pending approvals!',
                            ),
                            buildList(
                              context,
                              solved,
                              widget.controller,
                              'You have not solved any complaints yet!',
                            ),
                          ],
                        ),
                      );
                    } else {
                      final allComplaints = state.complaintList;

                      final pending = state.complaintList
                          .where((complaint) => complaint.status == "Registered")
                          .toList();

                      final inProcess = state.complaintList
                          .where((complaint) =>
                              complaint.status == "In Process" ||
                              complaint.status == 'Approval Pending')
                          .toList();

                      final onHold = state.complaintList
                          .where((complaint) => complaint.status == "On Hold")
                          .toList();

                      final solved = state.complaintList
                          .where((complaint) => complaint.status == 'Solved')
                          .toList();

                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 355,
                        child: TabBarView(
                          children: [
                            buildList(
                              context,
                              allComplaints,
                              widget.controller,
                              'There are no complaints in your department!',
                            ),
                            buildList(
                              context,
                              pending,
                              widget.controller,
                              'There are no pending complaints in your department',
                            ),
                            buildList(
                              context,
                              inProcess,
                              widget.controller,
                              'There are no complaints that are currently in process!',
                            ),
                            buildList(
                              context,
                              solved,
                              widget.controller,
                              'There are no solved complaints!',
                            ),
                            buildList(
                              context,
                              onHold,
                              widget.controller,
                              'There are no any complaints are on hold!',
                            ),
                          ],
                        ),
                      );
                    }
                  } else if (state is ComplaintError) {
                    return Center(
                      child: Text('Something went wrong: ${state.message}'),
                    );
                  } else {
                    return const Center(
                      child: Text('Unknown state'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(
      BuildContext context,
    List<ComplaintModel> list,
    ScrollController controller,
    String emptyText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: (list.isEmpty)
          ? Text(
            emptyText,
            style: Theme.of(context).textTheme.headlineMedium,
          )
          : ListView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                return ComplaintWidget(
                  complaint: list[index],
                );
              },
              itemCount: list.length,
            ),
    );
  }

  List<Tab> buildListTabs({required String type}) {
    return (type == 'hod')
        ? [
            buildTab(tabName: "All"),
            buildTab(tabName: "Pending"),
            buildTab(tabName: "In Process"),
            buildTab(tabName: "Solved"),
            buildTab(tabName: "On Hold"),
          ]
        : [
            buildTab(tabName: "Pending"),
            buildTab(tabName: "Taken"),
            buildTab(tabName: 'Solved'),
          ];
  }

  Tab buildTab({required String tabName}) {
    return Tab(
      child: SizedBox(
        height: 40,
        width: 120,
        child: Center(
          child: Text(
            tabName,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
