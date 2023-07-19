import 'package:act_hub_app/core/resources/manager_strings.dart';
import 'package:act_hub_app/features/auth/presentation/view/login_view.dart';
import 'package:act_hub_app/features/courses/presentation/view/screen/course_details_view.dart';
import 'package:act_hub_app/features/main/presentation/view/main_view.dart';
import 'package:act_hub_app/features/profile/presentation/view/screen/locale_view.dart';
import 'package:act_hub_app/features/splash/presentation/view/splash_view.dart';
import 'package:act_hub_app/features/verification/presentation/view/verification_view.dart';
import 'package:flutter/material.dart';
import '../config/dependency_injection.dart';
import '../features/auth/presentation/view/register_view.dart';
import '../features/courses/presentation/view/screen/payment_selection_view.dart';
import '../features/forget_password/presentation/view/forget_pass_view.dart';
import '../features/home/presentation/view/home_view.dart';
import '../features/out_boarding/presentation/view/out_boarding_view.dart';
import '../features/profile/presentation/view/screen/setting_view.dart';
import '../features/reset_password/presentation/view/reset_password_view.dart';

class Routes {
  static const String splashView = '/splash_view';
  static const String outBoardingView = '/out_boarding_view';
  static const String loginView = '/login_view';
  static const String verificationView = '/verification_view';
  static const String mainView = '/main_view';
  static const String homeView = '/home_view';
  static const String registerView = '/register_view';
  static const String forget_password = '/forget_password_view';
  static const String reset_password = '/reset_password';
  static const String setting = '/setting_view';
  static const String localeView = '/locale_view';
  static const String courseDetailsView = '/course_details_view';
  static const String paymentSelectionView = '/payment_selection_view';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        initSplash();
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.outBoardingView:
        initOutBoarding();
        return MaterialPageRoute(builder: (_) => const OutBoardingView());
      case Routes.loginView:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerView:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.verificationView:
        initVerificationModule();
        return MaterialPageRoute(builder: (_) => const VerificationView());
      case Routes.mainView:
        initMainModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.forget_password:
        initForgetPassword();
        return MaterialPageRoute(builder: (_) => ForgetPassView());
      case Routes.reset_password:
        initResetPasswordModule();
        return MaterialPageRoute(builder: (_) => ResetPasswordView());
      case Routes.setting:
        return MaterialPageRoute(builder: (_) => const SettingView());
      case Routes.localeView:
        return MaterialPageRoute(builder: (_) => const LocaleView());
        case Routes.courseDetailsView:
          initCourse();
        return MaterialPageRoute(builder: (_) => const CourseDetailsView());
      case Routes.paymentSelectionView:
        initSubscriptionProcess();
        return MaterialPageRoute(builder: (_) => PaymentSelectionView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(ManagerStrings.noRouteFound),
        ),
        body: Center(
          child: Text(ManagerStrings.noRouteFound),
        ),
      ),
    );
  }
}
