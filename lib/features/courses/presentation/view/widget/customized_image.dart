import 'package:act_hub_app/features/courses/presentation/controller/course_details_controller.dart';
import 'package:flutter/material.dart';
import '../../../../../core/resources/manager_sizes.dart';

class CustomImage extends StatelessWidget {
  CourseDetailsController controller;

  CustomImage({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        width: double.maxFinite,
        height: ManagerHeight.h375,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: controller.image(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
