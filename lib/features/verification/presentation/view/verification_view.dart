import 'package:act_hub_app/features/verification/presentation/controller/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/constants.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_fonts.dart';
import '../../../../core/resources/manager_sizes.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_styles.dart';
import '../../../../core/widgets/arrow_back_button.dart';
import '../../../../core/widgets/main_button.dart';
import 'widget/code_verification.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              ManagerStrings.verificationCode,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s18,
                color: ManagerColors.black,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            leading: arrowBackButton(color: ManagerColors.black),
          ),
          backgroundColor: ManagerColors.white,
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w20,
              vertical: ManagerHeight.h20,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ManagerHeight.h10,
                  ),
                  Text(
                    ManagerStrings.subTitleVerification,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s18,
                      color: ManagerColors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w24,
                      vertical: ManagerHeight.h4,
                    ),
                    child: Text(
                      ManagerStrings.verifyMessage,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: ManagerHeight.h30,
                  ),
                  Row(
                    children: [
                      CodeVerification(
                        controller: controller.firstCodeTextController,
                        focusNode: controller.firstFocusNode,
                        previousFocusNode: controller.firstFocusNode,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            controller.secondFocusNode.requestFocus();
                          }
                        },
                        validator: (value) =>
                            controller.validator.validateCode(value),
                      ),
                      SizedBox(
                        width: ManagerWidth.w10,
                      ),
                      CodeVerification(
                        controller: controller.secondCodeTextController,
                        focusNode: controller.secondFocusNode,
                        previousFocusNode: controller.firstFocusNode,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            controller.thirdFocusNode.requestFocus();
                          } else {
                            controller.firstFocusNode.requestFocus();
                          }
                        },
                        validator: (value) =>
                            controller.validator.validateCode(value),
                      ),
                      SizedBox(
                        width: ManagerWidth.w10,
                      ),
                      CodeVerification(
                        controller: controller.thirdCodeTextController,
                        focusNode: controller.thirdFocusNode,
                        previousFocusNode: controller.secondFocusNode,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            controller.fourthFocusNode.requestFocus();
                          }
                        },
                        validator: (value) =>
                            controller.validator.validateCode(value),
                      ),
                      SizedBox(
                        width: ManagerWidth.w10,
                      ),
                      CodeVerification(
                        controller: controller.fourthCodeTextController,
                        focusNode: controller.fourthFocusNode,
                        previousFocusNode: controller.thirdFocusNode,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            controller.fifthFocusNode.requestFocus();
                          }
                        },
                        validator: (value) =>
                            controller.validator.validateCode(value),
                      ),
                      SizedBox(
                        width: ManagerWidth.w10,
                      ),
                      CodeVerification(
                        controller: controller.fifthCodeTextController,
                        focusNode: controller.fifthFocusNode,
                        previousFocusNode: controller.fourthFocusNode,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            controller.sixthFocusNode.requestFocus();
                          }
                        },
                        validator: (value) =>
                            controller.validator.validateCode(value),
                      ),
                      SizedBox(
                        width: ManagerWidth.w10,
                      ),
                      CodeVerification(
                        controller: controller.sixthCodeTextController,
                        focusNode: controller.sixthFocusNode,
                        previousFocusNode: controller.fifthFocusNode,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
                            controller.verifyEmail(context);
                          }
                        },
                        validator: (value) =>
                            controller.validator.validateCode(value),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ManagerHeight.h10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ManagerStrings.resendCode,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      mainButton(
                        onPressed: () {
                          controller.sendOtp(context: context);
                        },
                        child: Text(
                          ManagerStrings.resend,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.primaryColor,
                          ),
                        ),
                        height: ManagerHeight.h8,
                        color: ManagerColors.transparent,
                        elevation: Constants.elevationButton,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
