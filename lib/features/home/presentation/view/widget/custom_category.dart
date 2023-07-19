import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/resources/manager_assets.dart';
import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_fonts.dart';
import '../../../../../core/resources/manager_sizes.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../controller/home_controller.dart';

class CustomCategory extends StatelessWidget {
  final String name;
  final String imagePath;
  final int? index;

  const CustomCategory(
      {Key? key, required this.name, required this.imagePath, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          controller.selectCategory(index!);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w6),
          margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
          decoration: BoxDecoration(
            color: controller.selectedCategoryIndex == index
                ? ManagerColors.selectedCategory
                : ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w4, vertical: ManagerHeight.h4),
                height: ManagerHeight.h40,
                width: ManagerWidth.w40,
                margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
                decoration: BoxDecoration(
                  color: controller.selectedCategoryIndex == index
                      ? ManagerColors.white
                      : ManagerColors.backgroundCategory.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(ManagerRadius.r6),
                ),
                child: imagePath.isNotEmpty
                    ? Image.network(imagePath)
                    : SvgPicture.asset(ManagerAssets.office),
              ),
              SizedBox(
                width: ManagerWidth.w4,
              ),
              Text(
                name,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: controller.selectedCategoryIndex == index
                      ? ManagerColors.white
                      : ManagerColors.black,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
