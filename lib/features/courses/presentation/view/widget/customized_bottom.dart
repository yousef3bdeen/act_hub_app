import 'package:flutter/material.dart';
import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_fonts.dart';
import '../../../../../core/resources/manager_sizes.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../../../../core/widgets/main_button.dart';

class CustomBottom extends StatelessWidget {
  final void Function() onPressed;
  final String price;

  const CustomBottom({Key? key, required this.onPressed, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      height: ManagerHeight.h80,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: ManagerColors.greyLight,
            spreadRadius: 3,
            blurRadius: 20,
          )
        ],
        color: ManagerColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            ManagerRadius.r10,
          ),
          topRight: Radius.circular(
            ManagerRadius.r10,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$$price",
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s20,
              color: ManagerColors.black,
            ),
          ),
          mainButton(
            color: ManagerColors.primaryColor,
            onPressed: onPressed,
            height: ManagerHeight.h40,
            child: Text(
              ManagerStrings.bookNow,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
