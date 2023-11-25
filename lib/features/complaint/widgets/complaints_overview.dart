import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcc_admin/bloc/complaint/complaint_bloc.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../constants/app_color.dart';

class ComplaintsOverview extends StatelessWidget {
  const ComplaintsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration:
          const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Image.asset(
                  UIUtils.getThumbnailName(
                      (context.read<LoginBloc>().state as LoggedIn)
                          .employee
                          .department),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 15,
                child: Text(
                  (context.read<LoginBloc>().state as LoggedIn)
                      .employee
                      .department,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                ),
              ),
            ],
          ),
          Container(
              width: size.width - 20,
              height: 75,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(color: AppColors.blue),
                  BoxShadow(color: Colors.black),
                ],
                color: AppColors.darkMidnightBlue,
              ),
              child: BlocBuilder<ComplaintBloc, ComplaintState>(
                builder: (context, state) {
                  if (state is ComplaintLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ComplaintError) {
                    return Text(state.message);
                  } else if (state is ComplaintLoaded) {
                    final registeredCount = state.complaintList
                        .where((complaint) => complaint.status == "Registered")
                        .length;
                    final inProcessCount = state.complaintList
                        .where((complaint) => complaint.status == "In Process")
                        .length;
                    final onHoldCount = state.complaintList
                        .where((complaint) => complaint.status == "On Hold")
                        .length;
                    final solvedCount = state.complaintList
                        .where((complaint) => complaint.status == "Solved")
                        .length;
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTextOfOverview(
                              value: registeredCount.toString(),
                              label: "Registered"),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          _buildTextOfOverview(
                              value: inProcessCount.toString(),
                              label: "In Process"),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          _buildTextOfOverview(
                              value: onHoldCount.toString(), label: "On Hold"),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          _buildTextOfOverview(
                              value: solvedCount.toString(), label: "Solved"),
                        ]);
                  } else {
                    return const Row(
                      children: [
                        Text("Unknown state"),
                      ],
                    );
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget _buildTextOfOverview({required String value, required String label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 12),
        )
      ],
    );
  }
}
