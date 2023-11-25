import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/model/complaint_model.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

import '../../../bloc/complaint/selected_complaint/selected_complaint_bloc.dart';
import '../../../constants/app_color.dart';

class RecentComplaintsCard extends StatelessWidget {
  const RecentComplaintsCard({super.key, required this.complaint});

  final ComplaintModel complaint;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/complaint_details');
        context.read<SelectedComplaintBloc>().add(
          LoadSelectedComplaint(complaint.id),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 150,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: AppColors.paleBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: Image.asset(
                  UIUtils.getIconName(complaint.departmentName),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      UIUtils.formatDate(complaint.registrationDate),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      complaint.departmentName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      complaint.subject,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: _buildSelectColor(status: complaint.status),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          complaint.status,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Complaint no. ",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          complaint.id,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "registered by ",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          complaint.applicantName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _buildSelectColor({required String status}) {
    switch (status) {
      case 'Registered':
        return AppColors.brightTurquoise;
      case 'In Process':
        return AppColors.heliotrope;
      case 'On Hold':
        return AppColors.monaLisa;
      default:
        return AppColors.mantis;
    }
  }
}
