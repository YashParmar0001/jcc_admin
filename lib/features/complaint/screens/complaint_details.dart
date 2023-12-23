import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jcc_admin/bloc/complaint/complaint_bloc.dart';
import 'package:jcc_admin/bloc/complaint/selected_complaint/selected_complaint_bloc.dart';
import 'package:jcc_admin/bloc/complaint/stats/complaint_stats_bloc.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/assets_constants.dart';
import '../../../utils/ui_utils.dart';

class ComplaintDetails extends StatefulWidget {
  const ComplaintDetails({super.key});

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  late TextEditingController remarksController;
  final images = <File>[];
  final picker = ImagePicker();

  @override
  void initState() {
    remarksController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats =
        (context.read<ComplaintStatsBloc>().state as ComplaintStatsLoaded)
            .stats;

    final employee = (context.read<LoginBloc>().state as LoggedIn).employee;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context
                .read<SelectedComplaintBloc>()
                .add(InitializeSelectedComplaint());
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
      body: WillPopScope(
        onWillPop: () async {
          context
              .read<SelectedComplaintBloc>()
              .add(InitializeSelectedComplaint());
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<SelectedComplaintBloc, SelectedComplaintState>(
              builder: (context, state) {
                if (state is SelectedComplaintLoading) {
                  return const CircularProgressIndicator();
                } else if (state is SelectedComplaintError) {
                  return Text(state.message);
                } else if (state is SelectedComplaintLoaded) {
                  final complaint = state.complaint;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 20) / 2,
                            child: _buildDataField(
                              context: context,
                              title: ScreensDataConstants.complaintNo,
                              text: complaint.id,
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 20) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ScreensDataConstants.status,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                        color: _buildSelectColor(
                                          status: complaint.status,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      complaint.status,
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
                            child: _buildDataField(
                              context: context,
                              title: ScreensDataConstants.registrationDate,
                              text: Conversion.formatDateTime(
                                complaint.registrationDate,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 20) / 2,
                            child: (!complaint.isAssigned)
                                ? _buildDataField(
                                    context: context,
                                    title: ScreensDataConstants
                                        .durationOfCompletion,
                                    text: "${complaint.noOfHours} Hours",
                                  )
                                // : _buildDataField(
                                //     context: context,
                                //     title: ScreensDataConstants.timeRemaining,
                                //     text: "05:23:45",
                                //     // "${complaint.noOfHours} Hours",
                                //   ),
                                : (complaint.status != 'Solved') ? _buildRemainingTime(
                                    DateTime.parse(
                                      complaint.trackData[1].date,
                                    ),
                                    complaint.noOfHours,
                                  ) : null,
                          ),
                        ],
                      ),
                      if (complaint.isAssigned && employee.type == 'hod')
                        const SizedBox(
                          height: 15,
                        ),
                      if (complaint.isAssigned && employee.type == 'hod')
                        _buildDataField(
                          context: context,
                          title: ScreensDataConstants.assignedEmpId,
                          text: complaint.assignedEmployeeId,
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildDataField(
                        context: context,
                        title: ScreensDataConstants.applicantName,
                        text: complaint.applicantName,
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
                            _buildDataField(
                              context: context,
                              title: ScreensDataConstants.applicantMobileNo,
                              text: complaint.userId,
                            ),
                            if (complaint.isAssigned)
                              IconButton(
                                onPressed: () {
                                  _makePhoneCall(complaint.userId);
                                },
                                icon: SvgPicture.asset(
                                  Assets.iconsPhoneCall,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _buildDataField(
                        context: context,
                        title: ScreensDataConstants.department,
                        text: complaint.departmentName,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildDataField(
                        context: context,
                        title: ScreensDataConstants.subject,
                        text: complaint.subject,
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
                            child: _buildDataField(
                              context: context,
                              title: ScreensDataConstants.areaName,
                              text: complaint.area,
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 20) / 2,
                            child: _buildDataField(
                              context: context,
                              title: ScreensDataConstants.wardNo,
                              text: complaint.ward,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildDataField(
                        context: context,
                        title: ScreensDataConstants.address,
                        text: (complaint.detailedAddress.isNotEmpty)
                            ? complaint.detailedAddress
                            : 'No address specified',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildDataFiled2(
                        context: context,
                        title: ScreensDataConstants.description,
                        text: complaint.description.isNotEmpty
                            ? complaint.description
                            : 'No description specified',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (complaint.isAssigned)
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: AppColors.platinum,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return _buildTimeLineItem(
                                      context: context,
                                      index: index,
                                      timeLine: complaint.trackData[index],
                                      length: complaint.trackData.length,
                                    );
                                  },
                                  itemCount: complaint.trackData.length,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      if (complaint.isAssigned)
                        Column(
                          children: [
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ScreensDataConstants.remarks,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (complaint.remarks.isNotEmpty)
                                    Text(
                                      complaint.remarks,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  if (complaint.remarks.isNotEmpty)
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  if (employee.type != 'hod')
                                    InkWell(
                                      onTap: () {
                                        _showRemarksDialog(
                                          context,
                                          complaint.remarks,
                                        );
                                      },
                                      child: Text(
                                        complaint.remarks.isNotEmpty
                                            ? 'Edit remarks'
                                            : 'Add remarks',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.brilliantAzure,
                                            ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
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
                                      0.0,
                                      0.0,
                                    ), // shadow direction: bottom right
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Image.network(
                                complaint.imageUrls[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: complaint.imageUrls.length,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (employee.type != 'hod')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!complaint.isAssigned)
                              PrimaryButton(
                                onTap: () {
                                  final employeeId = (context
                                          .read<LoginBloc>()
                                          .state as LoggedIn)
                                      .employee
                                      .employeeId;
                                  context.read<SelectedComplaintBloc>().add(
                                        TakeComplaint(
                                          assignedEmployeeId: employeeId,
                                          complaint: complaint,
                                          stats: stats,
                                        ),
                                      );
                                },
                                title: "Take Complaint",
                              ),
                            if (complaint.isAssigned &&
                                complaint.status == 'In Process')
                              _buildUploadImagesSection(context),
                            if (complaint.isAssigned &&
                                complaint.status == 'On Hold')
                              _buildCustomButton(
                                context: context,
                                onTap: () {
                                  context.read<SelectedComplaintBloc>().add(
                                        ResumeComplaint(
                                          complaint: complaint,
                                          stats: stats,
                                        ),
                                      );
                                },
                                title: 'Resume Progress',
                                color: AppColors.darkMidnightBlue,
                              ),
                            // if (complaint.isAssigned &&
                            //     !(complaint.status == "On Hold" ||
                            //         complaint.status == "Approval Pending"))
                            if (complaint.isAssigned &&
                                complaint.status == 'In Process')
                              _buildCustomButton(
                                context: context,
                                onTap: () {
                                  context.read<SelectedComplaintBloc>().add(
                                        HoldComplaint(
                                          complaint: complaint,
                                          stats: stats,
                                        ),
                                      );
                                },
                                title: "Put on Hold",
                                color: AppColors.monaLisa,
                              ),
                            if (complaint.isAssigned)
                              const SizedBox(
                                height: 15,
                              ),
                            // if (complaint.isAssigned &&
                            //     complaint.status != 'On Hold' &&
                            //     complaint.status != "Approval Pending")
                            if (complaint.isAssigned &&
                                complaint.status == 'In Process')
                              _buildCustomButton(
                                context: context,
                                onTap: () {
                                  // _showCompletionBottomSheet(context, complaint);
                                  context.read<SelectedComplaintBloc>().add(
                                        RequestApproval(
                                          complaint: complaint,
                                          images: images,
                                          stats: stats,
                                        ),
                                      );
                                },
                                title: "Request Approval",
                                color: AppColors.brilliantAzure,
                              ),
                            const SizedBox(height: 10,),
                            if (complaint.isAssigned &&
                                complaint.status == 'Approval Pending')
                              _buildCustomButton(
                                context: context,
                                onTap: () {
                                  context.read<SelectedComplaintBloc>().add(
                                        ResumeComplaint(
                                          complaint: complaint,
                                          stats: stats,
                                        ),
                                      );
                                },
                                title: 'Cancel Request',
                                color: AppColors.darkMidnightBlue,
                              ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                    ],
                  );
                } else {
                  return const Text('Unknown state');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadImagesSection(BuildContext scaffoldContext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Photo',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: images.length < 3 ? images.length + 1 : images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 187.5,
                height: 250,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.black25,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset:
                      Offset(0.0, 0.0), // shadow direction: bottom right
                    ),
                  ],
                  color: AppColors.antiFlashWhite,
                  image: (index < images.length)
                      ? DecorationImage(
                    image: FileImage(
                      images[index],
                    ),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: Center(
                  child: Stack(
                    children: [
                      if (index < images.length)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                images.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.black25),
                              child: SvgPicture.asset(
                                Assets.iconsDeleteBg,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (index == images.length)
                        Center(
                          child: IconButton(
                            onPressed: () {
                              getImage(
                                scaffoldContext: scaffoldContext,
                                index: index < images.length ? index : null,
                              );
                            },
                            icon: SvgPicture.asset(
                              width: 40,
                              height: 40,
                              Assets.iconsCircleAdd,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future getImage({required BuildContext scaffoldContext, int? index}) async {
    showBottomSheet(
      context: scaffoldContext,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Assets.iconsEdge),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Choose Option',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.pop();
                      getImageFromSource(source: ImageSource.camera);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.iconsCameraBg,
                          width: 50,
                        ),
                        const Text('Camera'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      context.pop();
                      getImageFromSource(source: ImageSource.gallery);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.iconsGalleryBg,
                          width: 50,
                        ),
                        const Text('Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Dismiss'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImageFromSource({required ImageSource source, int? index}) async {
    final pickedFile = await picker.pickImage(source: source);
    XFile? xFilePick = pickedFile;

    if (xFilePick != null) {
      final file = File(pickedFile!.path);

      setState(() {
        if (index != null) {
          images[index] = file;
        } else {
          images.add(file);
        }
      },
      );
    } else {
      UIUtils.showSnackBar(context, 'Nothing is selected');
    }
  }

  Future<void> _makePhoneCall(String phoneNo) async {
    final phoneNumber = Uri.parse('tel:$phoneNo');
    if (await canLaunchUrl(phoneNumber)) {
      await launchUrl(phoneNumber);
    }
  }

  void _showRemarksDialog(BuildContext context, String? remarks) {
    remarksController.text = remarks ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Remarks',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: remarksController,
                  style: Theme.of(context).textTheme.headlineSmall,
                  minLines: 2,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Add the Remarks',
                    hintStyle:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppColors.black60,
                            ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: AppColors.black60,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                PrimaryButton(
                    onTap: () {
                      context.pop();
                      if (remarksController.text.isNotEmpty) {
                        final complaintBloc =
                            context.read<SelectedComplaintBloc>();
                        final id =
                            (complaintBloc.state as SelectedComplaintLoaded)
                                .complaint
                                .id;
                        complaintBloc.add(AddRemarks(
                          complaintId: id,
                          remarks: remarksController.text,
                        ));
                      }
                    },
                    title: 'Save'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRemainingTime(DateTime takenDate, int durationInHours) {
    DateTime completionDate = takenDate.add(Duration(hours: durationInHours));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Remaining Time',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 5,
        ),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: completionDate.difference(DateTime.now()),
          builder: (context, value, child) {
            final remainingTime = completionDate.difference(DateTime.now());

            final hours = remainingTime.inHours;
            final minutes = remainingTime.inMinutes.remainder(60);
            final seconds = remainingTime.inSeconds.remainder(60);

            return Text(
              '$hours:$minutes:$seconds',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildDataField({
    required BuildContext context,
    required String title,
    required String text,
  }) {
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
        ),
      ],
    );
  }

  Widget _buildDataFiled2({
    required BuildContext context,
    required String title,
    required String text,
  }) {
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
            SizedBox(
              width: 100,
              child: Text(
                timeLine.status.toString(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
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
