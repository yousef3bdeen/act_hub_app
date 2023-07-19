import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/constants.dart';
import '../../routes/routes.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_icons.dart';
import '../resources/manager_sizes.dart';
import '../service/icon_service.dart';
import 'main_button.dart';

Widget arrowBackButton({Color? color}) {
  return Container(
    margin: EdgeInsetsDirectional.only(
      top: ManagerHeight.h12,
    ),
    child: mainButton(
      onPressed: () {
        Get.offAllNamed(Routes.loginView);
      },
      child: IconService().getIcon(
        icon: ManagerIcons.arrow_back_ios,
        color: color ?? ManagerColors.white,
        iconSize: ManagerIconSize.s24,
      ),
      color: ManagerColors.transparent,
      elevation: Constants.arrowBackButtonElevation,
    ),
  );
}
