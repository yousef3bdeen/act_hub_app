import 'package:act_hub_app/core/resources/manager_assets.dart';
import 'package:act_hub_app/core/resources/manager_colors.dart';
import 'package:act_hub_app/core/resources/manager_fonts.dart';
import 'package:act_hub_app/core/resources/manager_strings.dart';
import 'package:act_hub_app/core/resources/manager_styles.dart';
import 'package:act_hub_app/routes/routes.dart';
import 'package:flutter/material.dart';
import '../../../../../core/resources/manager_sizes.dart';
import '../../widgets/custom_general_item.dart';

class CustomGeneral extends StatelessWidget {
  const CustomGeneral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h10,
      ),
      padding: EdgeInsets.symmetric(
        vertical: ManagerHeight.h20,
        horizontal: ManagerWidth.w20,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.backgroundForm,
        borderRadius: BorderRadius.circular(
          ManagerRadius.r16,
        ),
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
          Text(
            'General',
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),
          Divider(),
          custom_general_item(
            icon: ManagerAssets.credit,
            title: 'credit',
          ),
          Divider(),
          custom_general_item(
            icon: ManagerAssets.global,
            title: 'language',
            onPressed: (){
              Navigator.pushNamed(context, Routes.localeView);
            },
          ),
          Divider(),
          custom_general_item(
            icon: ManagerAssets.card,
            title: 'payment',
          ),
        ],
      ),
    );
  }
}
