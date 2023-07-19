import 'package:act_hub_app/core/resources/manager_colors.dart';
import 'package:act_hub_app/core/resources/manager_fonts.dart';
import 'package:act_hub_app/core/resources/manager_strings.dart';
import 'package:act_hub_app/core/resources/manager_styles.dart';
import 'package:act_hub_app/features/profile/presentation/view/widget/custom_account.dart';
import 'package:act_hub_app/features/profile/presentation/view/widget/custom_general.dart';
import 'package:act_hub_app/features/profile/presentation/view/widget/custom_notification.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/manager_sizes.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ManagerColors.primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: ManagerColors.white),
        title: Text(
          'setting',
          style: getRegularTextStyle(
              fontSize: ManagerFontSize.s16, color: ManagerColors.white),
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: ManagerHeight.h60,
                color: ManagerColors.primaryColor,
              ),
              CustomNotification(),
            ],
          ),
          SizedBox(
            height: ManagerHeight.h30,
          ),
          CustomGeneral(),
          SizedBox(
            height: ManagerHeight.h30,
          ),
          CustomAccount()
        ],
      ),
    );
  }
}