import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/resources/manager_assets.dart';
import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_fonts.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../../../../routes/routes.dart';

AppBar homeAppBar() {
  return AppBar(
    title: Text(
      ManagerStrings.actHub,
      style: getRegularTextStyle(
        fontSize: ManagerFontSize.s22,
        color: ManagerColors.primaryColor,
      ),
    ),
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          ManagerAssets.search,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          ManagerAssets.notification,
        ),
      )
    ],
  );
}
