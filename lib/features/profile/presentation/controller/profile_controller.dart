import 'package:act_hub_app/core/storage/local/app_settings_shared_preferences.dart';
import 'package:act_hub_app/features/profile/data/request/edit_password_request.dart';
import 'package:act_hub_app/features/profile/domain/usecase/edit_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import '../../../../config/dependency_injection.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../routes/routes.dart';

class ProfileController extends GetxController {
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final AppSettingsSharedPreferences _appSettingsPrefs = instance<AppSettingsSharedPreferences>();
  var formKey = GlobalKey<FormState>();
  final EditPasswordUseCase _editPasswordUseCase = instance<EditPasswordUseCase>();

  changePassword() async {
    BuildContext context = Get.context!;
    dialogRender(
        context: context,
        message: ManagerStrings.loading,
        title: "",
        stateRenderType: StateRenderType.popUpLoadingState,
        retryAction: () {});
    (await _editPasswordUseCase.execute(EditPasswordRequest(
            password: newPassController.text,
            confirmPassword: confirmPassController.text)))
        .fold((l) {
      Get.back();
      dialogRender(
        context: context,
        message: l.message,
        title: 'editPassFailed',
        stateRenderType: StateRenderType.popUpErrorState,
        retryAction: () {
          Get.back();
        },
      );
    }, (r) {
      Get.back();
      dialogRender(
          context: context,
          message: 'Success',
          title: ManagerStrings.thanks,
          stateRenderType: StateRenderType.popUpSuccessState,
          retryAction: () {
            Get.back();
          });
    });
    newPassController.text = "";
    confirmPassController.text = "";
  }

}
