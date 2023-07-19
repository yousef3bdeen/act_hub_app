import 'package:act_hub_app/config/constants.dart';
import 'package:act_hub_app/core/cache/cache.dart';
import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/core/resources/manager_sizes.dart';
import 'package:act_hub_app/core/resources/manager_strings.dart';
import 'package:act_hub_app/core/storage/local/app_settings_shared_preferences.dart';
import 'package:act_hub_app/features/auth/domain/use_case/fcm_token_use_case.dart';
import 'package:act_hub_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import '../../../../config/dependency_injection.dart';
import '../../../../core/widgets/dialog_button.dart';
import '../../../../routes/routes.dart';
import '../../../verification/presentation/controller/verification_controller.dart';

class LoginController extends GetxController {
  late TextEditingController email = TextEditingController();
  late TextEditingController password = TextEditingController();
  late final LoginUseCase _loginUseCase = instance<LoginUseCase>();
  var formKey = GlobalKey<FormState>();
  final AppSettingsSharedPreferences _appSettingsSharedPreferences =
      instance<AppSettingsSharedPreferences>();
  bool rememberMe = false;
  final FcmTokenUseCase _tokenUseCase = instance<FcmTokenUseCase>();

  changeRememberMe(bool status) {
    rememberMe = status;
    update();
  }

  void performLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      _login(context);
    }
  }

  Future<void> _login(BuildContext context) async {
    CacheData cacheData = CacheData();
    cacheData.setEmail(email.text);
    dialogRender(
        context: context,
        stateRenderType: StateRenderType.popUpLoadingState,
        message: ManagerStrings.loading,
        title: '',
        retryAction: () {});
    (await _loginUseCase.execute(
      LoginUseCaseInput(email: email.text, password: password.text),
    ))
        .fold((l) {
      Get.back();
      dialogRender(
        context: context,
        stateRenderType: StateRenderType.popUpErrorState,
        message: l.message,
        title: '',
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w65,
          ),
          child: dialogButton(
              message: ManagerStrings.ok,
              onPressed: () async {
                Get.back();
                if (l.message == ManagerStrings.notVerifiedEmail) {
                  await VerificationController().sendOtp(
                    context: context,
                    route: Routes.verificationView,
                  );
                }
              }),
        ),
      );
    }, (r) async {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      _tokenUseCase.execute(FcmTokenUseCaseInput(fcmToken: fcmToken));

      if (rememberMe) {
        _appSettingsSharedPreferences.setEmail(email.text);
        _appSettingsSharedPreferences.setPassword(password.text);
        _appSettingsSharedPreferences.setLoggedIn();
      }
      _appSettingsSharedPreferences.setToken(r.token.onNull());
      Get.back();
      dialogRender(
        context: context,
        stateRenderType: StateRenderType.popUpSuccessState,
        message: ManagerStrings.thanks,
        title: '',
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w65,
          ),
          child: dialogButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed(Routes.mainView);
            },
            message: ManagerStrings.thanks,
          ),
        ),
      );
      Future.delayed(
          const Duration(
            seconds: Constants.loginTimer,
          ), () {
        Get.offAllNamed(Routes.mainView);
      });
    });
  }
}
