// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/employee/selected_employee/selected_employee_bloc.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

import 'dart:developer' as dev;

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
          'Profile',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            SizedBox(
              height: 138,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                UIUtils.getThumbnailName("Water Works"),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: "",
                          imageBuilder: (context, imageProvider) {
                            return Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            );
                          },
                          placeholder: (context, url) {
                            return Image.asset(
                              Assets.imagesDefaultProfile,
                              fit: BoxFit.cover,
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              Assets.imagesDefaultProfile,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  _buildEmployDataField(
                    context: context,
                    title: "Full name ",
                    data:
                    "Pedhadiya Jay K.",
                  ),
                  _buildEmployDataField(
                    context: context,
                    title: "Employee ID",
                    data: "32988233",
                  ),
                  _buildEmployDataField(
                    context: context,
                    title: "Mobile No",
                    data: "9313096952",
                  ),
                  _buildEmployDataField(
                    context: context,
                    title: "Email",
                    data: "pedhadiyajay5230@gmail.com",
                  ),
                  _buildEmployDataField(
                    context: context,
                    title: "Department",
                    data: "Water Works",
                  ),
                  _buildEmployDataField(
                    context: context,
                    title: "Post",
                    data: "Employee",
                  ),
                  _buildEmployDataField(
                    context: context,
                    title: "Ward no",
                    data: "1",
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _buildEmployDataField({required BuildContext context, required String title, required String data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.darkMidnightBlue50,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppColors.darkMidnightBlue,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 15)
      ],
    );
  }
}
