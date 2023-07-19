import 'package:act_hub_app/core/resources/manager_assets.dart';
import 'package:act_hub_app/core/resources/manager_colors.dart';
import 'package:act_hub_app/core/resources/manager_fonts.dart';
import 'package:act_hub_app/core/resources/manager_strings.dart';
import 'package:act_hub_app/core/resources/manager_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/resources/manager_sizes.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h100,
      margin: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16, vertical: ManagerHeight.h10),
      decoration: BoxDecoration(
        color: ManagerColors.backgroundForm,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ManagerColors.greyLight,
            offset: Offset(0.0, 2.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w10, vertical: ManagerHeight.h6),
            child: Text(
              'notifications',
              style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(
              left: ManagerWidth.w14,
            ),
            child: Row(
              children: [
                SvgPicture.asset(ManagerAssets.notification2),
                SizedBox(
                  width: ManagerWidth.w10,
                ),
                Text(
                  'notifications',
                  style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.textColorProfile),
                ),
                Spacer(),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    value: true,
                    onChanged: (val) {},
                    activeColor: ManagerColors.activeSwitchColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
