import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jcc_admin/constants/app_color.dart';
import 'package:jcc_admin/generated/assets.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(height: 80),
            Row(
              children: [
                SizedBox(width: 20),
                Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    Assets.iconsUser,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: AppColors.darkMidnightBlue,
                  width: 2,
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Employee Name",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("+91 63555 55555"),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            ListTile(
              leading: SvgPicture.asset('assets/icons/language.svg'),
              title: Text("Language"),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/about_us.svg'),
              title: Text("About Us"),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/help.svg'),
              title: Text("Need any help?"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
