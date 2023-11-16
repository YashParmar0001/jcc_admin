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
    return DefaultTabController(
      length: 2,
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
              onPressed: () {
              },
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const ComplaintsOverview(),
              const SizedBox(
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
                      final takenList = state.complaintList
                          .where((complaint) =>
                              complaint.isAssigned &&
                              complaint.assignedEmployeeId == id)
                          .toList();

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
