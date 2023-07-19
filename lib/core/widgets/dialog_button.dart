import 'package:flutter/material.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_fonts.dart';
import '../resources/manager_sizes.dart';
import '../resources/manager_styles.dart';
import 'main_button.dart';

Widget dialogButton({
  void Function()? onPressed,
  required String message,
}) {
  return mainButton(
    child: Text(
      message,
      style: getMediumTextStyle(
        fontSize: ManagerFontSize.s16,
        color: ManagerColors.white,
      ),
    ),
    onPressed: onPressed,
    color: ManagerColors.primaryColor,
    height: ManagerHeight.h40,
  );
}
