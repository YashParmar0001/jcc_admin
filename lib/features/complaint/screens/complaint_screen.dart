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
      length: (type == 'hod') ? 5 : 2,
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
        body: Column(
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
                    final takenList = state.complaintList
                        .where((complaint) =>
                            complaint.isAssigned &&
                            complaint.assignedEmployeeId == id)
                        .toList();

                    final all = state.complaintList;
                    final pending = state.complaintList
                        .where((complaint) => complaint.status == "Registered")
                        .toList();
                    final inProcess = state.complaintList
                        .where((complaint) => complaint.status == "In Process")
                        .toList();
                    final onHold = state.complaintList
                        .where((complaint) => complaint.status == "On Hold")
                        .toList();
                    final Solved = state.complaintList
                        .toList();
                    return (type == 'hod')
                        ? TabBarView(
                            children: [
                              buildList(all),
                              buildList(pending),
                              buildList(inProcess),
                              buildList(onHold),
                              buildList(Solved),
                            ],
                          )
                        : TabBarView(
                            children: [
                              buildList(state.complaintList.where((complaint) => complaint.status == "Registered" && !complaint.isAssigned).toList()),
                              buildList(takenList),
                            ],
                          );
                  }

                  return (type == 'hod')
                      ? TabBarView(
                          children: [
                            buildList([]),
                            buildList([]),
                            buildList([]),
                            buildList([]),
                            buildList([]),
                          ],
                        )
                      : TabBarView(
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
    );
  }

  Widget buildList(List<ComplaintModel> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ComplaintWidget(
            complaint: list[index],
          );
        },
        itemCount: list.length,

        // shrinkWrap: true,
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
