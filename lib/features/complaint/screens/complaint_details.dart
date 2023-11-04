import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jcc_admin/bloc/complaint/selected_complaint/selected_complaint_bloc.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/common/widget/primary_button.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/constants/string_constants.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/model/complaint_model.dart';
import 'package:jcc_admin/utils/conversion.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ComplaintDetails extends StatelessWidget {
  const ComplaintDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(
            Assets.iconsBackArrow,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          CommonDataConstants.complaintDetails,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 22,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 20) / 2,
                    child: _buildDataFiled(
                      context: context,
                      title: ScreensDataConstants.complaintNo,
                      text: "2",
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 20) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ScreensDataConstants.status,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                color: _buildSelectColor(status: "Registered"),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Registered",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 20) / 2,
                    child: _buildDataFiled(
                      context: context,
                      title: ScreensDataConstants.registrationDate,
                      text: "Fri, 03 Nov 2023, 08:11 AM",
                      // Conversion.formatDateTime(complaint.registrationDate),
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 20) / 2,
                    child: _buildDataFiled(
                      context: context,
                      title: ScreensDataConstants.durationOfCompletion,
                      text: "40 Hours",
                      // "${complaint.noOfHours} Hours",
                    ),

                    // _buildDataFiled(
                    //   context: context,
                    //   title: ScreensDataConstants.timeRemaining,
                    //   text: "05:23:45",
                    //   // "${complaint.noOfHours} Hours",
                    // ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              _buildDataFiled(
                context: context,
                title: ScreensDataConstants.applicantName,
                text: "Jay Pedhadiya",
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildDataFiled(
                      context: context,
                      title: ScreensDataConstants.applicantMobileNo,
                      text: "+91 93130 96952",
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: SvgPicture.asset(
                    //     Assets.iconsPhoneCall,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              _buildDataFiled(
                context: context,
                title: ScreensDataConstants.department,
                text: "Health",
              ),
              const SizedBox(
                height: 15,
              ),
              _buildDataFiled(
                context: context,
                title: ScreensDataConstants.subject,
                text: "Food Checking",
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 20) / 2,
                    child: _buildDataFiled(
                      context: context,
                      title: ScreensDataConstants.areaName,
                      text: "RameshWarnagar",
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 20) / 2,
                    child: _buildDataFiled(
                      context: context,
                      title: ScreensDataConstants.wardNo,
                      text: "3",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              _buildDataFiled(
                context: context,
                title: ScreensDataConstants.address,
                text: "near ram mandir",
              ),
              const SizedBox(
                height: 15,
              ),
              _buildDataFiled2(
                context: context,
                title: ScreensDataConstants.description,
                text: "food check",
              ),
              const SizedBox(
                height: 15,
              ),


              // Container(
              //   width: MediaQuery.of(context).size.width - 20,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20.0),
              //     color: AppColors.platinum,
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(40.0),
              //     child: ListView.builder(
              //       physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //         return _buildTimeLineItem(
              //           context: context,
              //           index: index,
              //           timeLine: complaint.trackData[index],
              //           length: complaint.trackData.length,
              //         );
              //       },
              //       itemCount: complaint.trackData.length,
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),

              // const SizedBox(
              //   height: 15,
              // ),

              // SizedBox(
              //   child:  Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         ScreensDataConstants.remarks,
              //         style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 5,
              //       ),
              //       InkWell(
              //         onTap: () {
              //
              //         },
              //         child: Text(
              //           "Add the Remarks",
              //           style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              //             fontWeight: FontWeight.w400,
              //             color: AppColors.brilliantAzure,
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              //

              // const SizedBox(
              //   height: 15,
              // ),

              Text(
                ScreensDataConstants.photographs,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 250,
                      width: 187.5,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        color: AppColors.black50,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black25,
                            blurRadius: 1.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                0.0, 0.0), // shadow direction: bottom right
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        Assets.departmentIconsSolidWaste,
                        fit: BoxFit.cover,
                      ),

                      // Image.network(
                      //   complaint.imageUrls[index],
                      //   fit: BoxFit.cover,
                      // ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: 3,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              PrimaryButton(
                onTap: () {},
                title: "Take Complaint",
              ),


              // const SizedBox(
              //   height: 15,
              // ),
              // _buildCustomButton(
              //   context: context,
              //   onTap: () {},
              //   title: "Put on Hold",
              //   color: AppColors.monaLisa,
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // _buildCustomButton(
              //   context: context,
              //   onTap: () {},
              //   title: "Mark as Solved",
              //   color: AppColors.brilliantAzure,
              // ),


              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataFiled(
      {required BuildContext context,
      required String title,
      required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        )
      ],
    );
  }

  Widget _buildDataFiled2(
      {required BuildContext context,
      required String title,
      required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        )
      ],
    );
  }

  Widget _buildTimeLineItem({
    required BuildContext context,
    required int index,
    required TimeLine timeLine,
    required int length,
  }) {
    return SizedBox(
      height: 100,
      child: TimelineTile(
        isFirst: index == 0 ? true : false,
        isLast: index == length - 1 ? true : false,
        alignment: TimelineAlign.center,
        axis: TimelineAxis.vertical,
        indicatorStyle: IndicatorStyle(
            iconStyle: IconStyle(
                iconData: Icons.circle,
                color: _buildSelectColor(status: timeLine.status.toString()),
                fontSize: 24),
            width: 24,
            height: 24,
            drawGap: true,
            color: AppColors.brilliantAzure),
        beforeLineStyle: const LineStyle(
          color: AppColors.darkMidnightBlue,
          thickness: 3,
        ),
        startChild: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              Conversion.formatDate(timeLine.date.toString()),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        endChild: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              timeLine.status.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(
      {required BuildContext context,
      required VoidCallback onTap,
      required String title,
      required Color color}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.white,
                ),
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
