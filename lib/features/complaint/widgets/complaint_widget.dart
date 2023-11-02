import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../../constants/app_color.dart';
import '../../../model/complaint_model.dart';
import '../../../utils/ui_utils.dart';

class ComplaintWidget extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintWidget({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.go('/complaints/complaint_details');
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.geryis),
          color: AppColors.antiFlashWhite,
          borderRadius: BorderRadius.circular(15),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Color(0x3F000000),
          //     blurRadius: 2,
          //     offset: Offset(0, 2),
          //     spreadRadius: 0,
          //   )
          // ],
        ),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UIUtils.formatDate(complaint.registrationDate),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  complaint.subject,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                buildStatus(
                  context,
                  AppColors.monaLisa,
                  complaint.status,
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Complaint no. ',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: complaint.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'registered by ',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
              ),),
          Text(
              complaint.applicantName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
              ),
          )
          ],
        )],
            )

      ),
    );
  }

  Widget buildStatus(BuildContext context, Color color, String status) {
    return Row(
      children: [
        Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          status,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 10, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

}