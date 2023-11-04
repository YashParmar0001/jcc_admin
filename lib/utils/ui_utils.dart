import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/string_constants.dart';

class UIUtils {
  static String getIconName(String departmentName) {
    int index =
    DepartmentDataConstants.departmentNameList.indexOf(departmentName);
    return DepartmentDataConstants.departmentIconsAssetsName.elementAt(index);
  }

  static void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  static String formatDate(DateTime timeStamp) =>
      DateFormat('E, dd MMM yyyy, hh:mm a').format(timeStamp);

  static String getThumbnailName(String departmentName){
    int index =
    DepartmentDataConstants.departmentNameList.indexOf(departmentName);
    return DepartmentDataConstants.departmentThumbnailIcons.elementAt(index);
  }
}