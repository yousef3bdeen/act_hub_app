import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/resources/manager_sizes.dart';
import '../../../../../routes/routes.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ManagerWidth.w40,
      height: ManagerHeight.h40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ManagerRadius.r10,
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () {
          Get.offAllNamed(Routes.mainView);
        },
      ),
    );
  }
}
