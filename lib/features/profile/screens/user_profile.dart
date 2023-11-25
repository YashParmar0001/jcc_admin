// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc_admin/bloc/login/login_bloc.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';
import 'package:jcc_admin/utils/ui_utils.dart';

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
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoggedIn){
              return Stack(
                children: [
                  SizedBox(
                    height: 138,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      UIUtils.getThumbnailName(state.employee.department),
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
                                imageUrl: state.employee.photoUrl,
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
                          data: "${state.employee.firstName} ${state.employee.middleName} ${state.employee.lastName}",
                        ),
                        _buildEmployDataField(
                          context: context,
                          title: "Employee ID",
                          data: state.employee.employeeId,
                        ),
                        _buildEmployDataField(
                          context: context,
                          title: "Mobile No",
                          data: state.employee.phone,
                        ),
                        _buildEmployDataField(
                          context: context,
                          title: "Email",
                          data: state.employee.email,
                        ),
                        _buildEmployDataField(
                          context: context,
                          title: "Department",
                          data: state.employee.department,
                        ),
                        _buildEmployDataField(
                          context: context,
                          title: "Post",
                          data: state.employee.type,
                        ),
                        _buildEmployDataField(
                          context: context,
                          title: "Ward no",
                          data: state.employee.ward,
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is LoggedOut) {
              return Container();
            } else {
              return const Row(
                children: [
                  Text("Unknown state")
                ],
              );
            }
          },
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
