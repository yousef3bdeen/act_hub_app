import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/courses/presentation/controller/stepper_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/resources/manager_assets.dart';
import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_fonts.dart';
import '../../../../../core/resources/manager_sizes.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../model/course_details_data_attribute_model.dart';

Container courseItem(CourseDetailsDataAttributeModel attribute) {
  return Container(
    height: ManagerHeight.h110,
    decoration: BoxDecoration(
      color: ManagerColors.white,
      borderRadius: BorderRadius.circular(
        ManagerRadius.r10,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
          child: Image.network(
            attribute.avatar.toString(),
            width: ManagerWidth.w128,
            height: ManagerHeight.h110,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: ManagerWidth.w10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w6,
                vertical: ManagerHeight.h6,
              ),
              margin: EdgeInsets.only(
                top: ManagerHeight.h6,
              ),
              decoration: BoxDecoration(
                color: ManagerColors.backgroundCourses,
                borderRadius: BorderRadius.circular(
                  ManagerRadius.r4,
                ),
              ),
              child: Text(
                ManagerStrings.design,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ),
            Text(
              attribute.name.toString(),
              style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s14, color: ManagerColors.black),
            ),
            SizedBox(
              height: ManagerHeight.h10,
            ),
            Text(
              StepperController().courseHoursFormat(
                attribute.hours!.onNull(),
              ),
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          margin: EdgeInsets.only(
            top: ManagerHeight.h10,
            right: ManagerWidth.w10,
            bottom: ManagerHeight.h10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SvgPicture.asset(ManagerAssets.star),
                  Text(
                    ManagerStrings.rate,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
