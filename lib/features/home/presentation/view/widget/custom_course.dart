import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/resources/manager_assets.dart';
import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_fonts.dart';
import '../../../../../core/resources/manager_sizes.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../controller/home_controller.dart';

class CustomCourse extends StatelessWidget {
  final void Function()? onTap;
  final int index;
  final HomeController controller;

  const CustomCourse(
      {Key? key, this.onTap, required this.index, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w10,
        ),
        width: double.infinity,
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
                controller.popularCourses[index].attributeCourseModel!.avatar
                    .toString(),
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
                  controller.popularCourses[index].attributeCourseModel!.title
                      .toString(),
                  style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.black),
                ),
                SizedBox(
                  height: ManagerHeight.h10,
                ),
                Text(
                  controller.courseHoursFormat(index),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: SvgPicture.asset(
                      ManagerAssets.save,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ManagerAssets.star,
                      ),
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
      ),
    );
  }
}
