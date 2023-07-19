import 'package:act_hub_app/config/constants.dart';
import 'package:act_hub_app/config/dependency_injection.dart';
import 'package:act_hub_app/core/storage/local/app_settings_shared_preferences.dart';
import 'package:act_hub_app/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AppSettingsSharedPreferences _appSettingsSharedPreferences =
      instance<AppSettingsSharedPreferences>();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(
        const Duration(
          seconds: Constants.splashDuration,
        ), () {
      if (_appSettingsSharedPreferences.getOutBoardingViewed()) {
        if (_appSettingsSharedPreferences.loggedIn()) {
          Get.offAllNamed(Routes.mainView);
        } else {
          Get.offAllNamed(Routes.loginView);
        }
      } else {
        Get.offAllNamed(
          Routes.outBoardingView,
        );
      }
    });
  }
}
