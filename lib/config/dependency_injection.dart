import 'package:act_hub_app/core/internet_checker/internet_checker.dart';
import 'package:act_hub_app/core/network/app_api.dart';
import 'package:act_hub_app/core/network/dio_factory.dart';
import 'package:act_hub_app/core/storage/local/app_settings_shared_preferences.dart';
import 'package:act_hub_app/core/storage/remote/firebase/controllers/fb_notifications.dart';
import 'package:act_hub_app/features/auth/data/data_source/remote_Register_data_source.dart';
import 'package:act_hub_app/features/auth/data/data_source/remote_fcm_token_data_source.dart';
import 'package:act_hub_app/features/auth/data/data_source/remote_login_data_source.dart';
import 'package:act_hub_app/features/auth/data/repository_impl/fcm_token_repository_impl.dart';
import 'package:act_hub_app/features/auth/data/repository_impl/login_repository_impl.dart';
import 'package:act_hub_app/features/auth/data/repository_impl/register_repository_impl.dart';
import 'package:act_hub_app/features/auth/domain/repository/register_repository.dart';
import 'package:act_hub_app/features/auth/domain/repository/fcm_token_repository.dart';
import 'package:act_hub_app/features/auth/domain/repository/login_repository.dart';
import 'package:act_hub_app/features/auth/domain/use_case/fcm_token_use_case.dart';
import 'package:act_hub_app/features/auth/domain/use_case/login_use_case.dart';
import 'package:act_hub_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:act_hub_app/features/courses/data/data_source/course_details_data_source.dart';
import 'package:act_hub_app/features/courses/data/repository/course_details_respository.dart';
import 'package:act_hub_app/features/courses/domain/usecase/course_details_usecase.dart';
import 'package:act_hub_app/features/courses/presentation/controller/course_details_controller.dart';
import 'package:act_hub_app/features/home/data/data_source/remote_home_data_source.dart';
import 'package:act_hub_app/features/home/data/repository_implementation/home_repository_implementation.dart';
import 'package:act_hub_app/features/home/domain/repository/home_repository.dart';
import 'package:act_hub_app/features/home/domain/usecase/home_usecase.dart';
import 'package:act_hub_app/features/home/presentation/controller/home_controller.dart';
import 'package:act_hub_app/features/splash/presentation/controller/splash_controller.dart';
import 'package:act_hub_app/features/verification/data/data_source/remote_verification_data_source.dart';
import 'package:act_hub_app/features/verification/data/respository_impl/verify_email_respository_impl.dart';
import 'package:act_hub_app/features/verification/domain/repositories/verification_repository.dart';
import 'package:act_hub_app/features/verification/domain/usecase/verification_usecase.dart';
import 'package:act_hub_app/features/verification/presentation/controller/verification_controller.dart';
import 'package:act_hub_app/firebase_options_.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/auth/presentation/controller/login_controller.dart';
import '../features/auth/presentation/controller/register_controller.dart';
import '../features/courses/data/data_source/course_rating_data_source.dart';
import '../features/courses/data/data_source/course_subscription_data_source.dart';
import '../features/courses/data/repository/course_rating_repo_impl.dart';
import '../features/courses/data/repository/course_subscription_repo_impl.dart';
import '../features/courses/domain/usecase/course_rating_usecase.dart';
import '../features/courses/domain/usecase/course_subscription_usecase.dart';
import '../features/courses/presentation/controller/stepper_controller.dart';
import '../features/edit_profile/data/data_source/profile_remote_data_source.dart';
import '../features/edit_profile/data/respository_impl/profile_repository_impl.dart';
import '../features/edit_profile/domain/repository/profile_repository.dart';
import '../features/edit_profile/domain/usecase/profile_usecase.dart';
import '../features/forget_password/data/data_souces/remote_data_source.dart';
import '../features/forget_password/data/repoitory_impl/forget_password_repository_impl.dart';
import '../features/forget_password/domain/repositroy/forget_password_repositroy.dart';
import '../features/forget_password/domain/usecase/forget_password_usecase.dart';
import '../features/forget_password/presentation/controller/forget_pass_controller.dart';
import '../features/main/presentation/controller/main_controller.dart';
import '../features/out_boarding/presentation/controller/out_boarding_controller.dart';
import '../features/payment/data/data_source/payments_remote_data_source.dart';
import '../features/payment/data/repository_impl/payments_respoitory_impl.dart';
import '../features/payment/domain/repository/payments_repository.dart';
import '../features/payment/domain/usecase/payments_usecase.dart';
import '../features/profile/data/data_source/edit_password_remote_data_source.dart';
import '../features/profile/data/repository_impl/edit_password_repository_impl.dart';
import '../features/profile/domain/repository/edit_password_repository.dart';
import '../features/profile/domain/usecase/edit_password_usecase.dart';
import '../features/profile/presentation/controller/locale_notifier_controller.dart';
import '../features/profile/presentation/controller/profile_controller.dart';
import '../features/reset_password/data/data_souces/reset_password_remote_data_source.dart';
import '../features/reset_password/data/repoitory_impl/reset_password_repository_impl.dart';
import '../features/reset_password/domain/repositroy/reset_password_repositroy.dart';
import '../features/reset_password/domain/usecase/reset_password_use_case.dart';
import '../features/reset_password/presentation/controller/reset_password_controller.dart';
import '../features/verification/data/data_source/send_otp_remote_date_source.dart';
import '../features/verification/data/respository_impl/send_otp_respository_impl.dart';
import '../features/verification/domain/repositories/send_otp_repository.dart';
import '../features/verification/domain/usecase/send_otp_usecase.dart';

final instance = GetIt.instance;

firebaseModule() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FbNotifications fb = FbNotifications();
  await FbNotifications.initNotifications();
  await fb.requestNotificationPermissions();
  await fb.initializeForegroundNotificationForAndroid();
  fb.manageNotificationAction();
  print(await FirebaseMessaging.instance.getToken());
}

initModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await firebaseModule();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  instance.registerLazySingleton<AppSettingsSharedPreferences>(
      () => AppSettingsSharedPreferences(instance()));

  // TODO: ONLY FOR TEST
  // AppSettingsSharedPreferences appSettingsSharedPreferences =
  //     instance<AppSettingsSharedPreferences>();
  // appSettingsSharedPreferences.clear();

  instance.registerLazySingleton(() => DioFactory());

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppApi>(
    () => AppApi(dio),
  );

  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionCheckerPlus(),
    ),
  );
}

initSplash() {
  Get.put<SplashController>(SplashController());
}

disposeSplash() {
  Get.delete<SplashController>();
}

initOutBoarding() {
  disposeSplash();
  Get.put<OutBoardingController>(OutBoardingController());
}

disposeOutBoarding() {
  Get.delete<OutBoardingController>();
}

initLoginModule() {
  disposeSplash();
  disposeOutBoarding();
  disposeRegisterModule();
  initVerificationModule();
  initFcmToken();
  if (!GetIt.I.isRegistered<RemoteLoginDataSource>()) {
    instance.registerLazySingleton<RemoteLoginDataSource>(
      () => RemoteLoginDataSourceImplement(
        instance<AppApi>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<LoginRepository>()) {
    instance.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(
        instance(),
        instance(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(
        instance<LoginRepository>(),
      ),
    );
  }

  Get.put<LoginController>(LoginController());
}

disposeLoginModule() {
  disposeFcmToken();

  if (GetIt.I.isRegistered<RemoteLoginDataSource>()) {
    instance.unregister<RemoteLoginDataSource>();
  }

  if (GetIt.I.isRegistered<LoginRepository>()) {
    instance.unregister<LoginRepository>();
  }

  if (GetIt.I.isRegistered<LoginUseCase>()) {
    instance.unregister<LoginUseCase>();
  }

  Get.delete<LoginController>();
}

initRegisterModule() {
  disposeLoginModule();
  if (!GetIt.I.isRegistered<RemoteRegisterDataSource>()) {
    instance.registerLazySingleton<RemoteRegisterDataSource>(
      () => RemoteRegisterDataSourceImplement(
        instance<AppApi>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<RegisterRepository>()) {
    instance.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(
        instance<RemoteRegisterDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(
        instance<RegisterRepository>(),
      ),
    );
  }

  Get.put<RegisterController>(RegisterController());
}

disposeRegisterModule() {
  if (GetIt.I.isRegistered<RemoteRegisterDataSource>()) {
    instance.unregister<RemoteRegisterDataSource>();
  }

  if (GetIt.I.isRegistered<RegisterRepository>()) {
    instance.unregister<RegisterRepository>();
  }

  if (GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.unregister<RegisterUseCase>();
  }

  Get.delete<RegisterController>();
}

initMainModule() {
  Get.put<MainController>(MainController());
  initHomeModule();
}

initHomeModule() {
  if (!GetIt.I.isRegistered<RemoteHomeDataSource>()) {
    instance.registerLazySingleton<RemoteHomeDataSource>(
      () => RemoteHomeDataSourceImplement(
        instance<AppApi>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<HomeRepository>()) {
    instance.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImplementation(
        instance<RemoteHomeDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerLazySingleton<HomeUseCase>(
      () => HomeUseCase(
        instance<HomeRepository>(),
      ),
    );
  }

  Get.put<HomeController>(HomeController());
  initProfile();
  disposeCourse();
}

initProfile() {
  initChangePassword();

  if (!GetIt.I.isRegistered<RemoteProfileDataSource>()) {
    instance.registerLazySingleton<RemoteProfileDataSource>(
        () => RemoteProfileDataSourceImplement(instance()));
  }
  if (!GetIt.I.isRegistered<ProfileRepository>()) {
    instance.registerLazySingleton<ProfileRepository>(
        () => ProfileRepoImplement(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<ProfileUseCase>()) {
    instance.registerFactory<ProfileUseCase>(
        () => ProfileUseCase(instance<ProfileRepository>()));
  }

  Get.put<LocaleNotifierController>(LocaleNotifierController());
  Get.put<ProfileController>(ProfileController());
}

disposeProfile() {
  Get.delete<ProfileController>();
  if (GetIt.I.isRegistered<RemoteProfileDataSource>()) {
    instance.unregister<RemoteProfileDataSource>();
  }

  if (GetIt.I.isRegistered<ProfileRepository>()) {
    instance.unregister<ProfileRepository>();
  }

  if (GetIt.I.isRegistered<ProfileUseCase>()) {
    instance.unregister<ProfileUseCase>();
  }
}

initChangePassword() {
  if (!GetIt.I.isRegistered<RemoteEditPasswordDataSource>()) {
    instance.registerLazySingleton<RemoteEditPasswordDataSource>(
        () => RemoteEditPasswordDateSourceImplement(instance()));
  }

  if (!GetIt.I.isRegistered<EditPasswordRepository>()) {
    instance.registerLazySingleton<EditPasswordRepository>(
        () => EditPasswordRepoImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<EditPasswordUseCase>()) {
    instance.registerFactory<EditPasswordUseCase>(
        () => EditPasswordUseCase(instance<EditPasswordRepository>()));
  }
}

initVerificationModule() {
  initSendOtp();

  if (!GetIt.I.isRegistered<RemoteVerificationDataSource>()) {
    instance.registerLazySingleton<RemoteVerificationDataSource>(
      () => RemoteVerificationDataSourceImplementation(
        instance<AppApi>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<VerificationRepository>()) {
    instance.registerLazySingleton<VerificationRepository>(
      () => VerificationRepositoryImpl(
        instance<NetworkInfo>(),
        instance<RemoteVerificationDataSource>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<VerificationUseCase>()) {
    instance.registerLazySingleton<VerificationUseCase>(
      () => VerificationUseCase(
        instance<VerificationRepository>(),
      ),
    );
  }

  Get.put<VerificationController>(VerificationController());
}

initForgetPassword() async {
  disposeLoginModule();
  initSendOtp();

  if (!GetIt.I.isRegistered<ForgetPasswordDataSource>()) {
    instance.registerLazySingleton<ForgetPasswordDataSource>(
        () => RemoteForgetPasswordDataSourceImpl(instance<AppApi>()));
  }

  if (!GetIt.I.isRegistered<ForgetPasswordRepository>()) {
    instance.registerLazySingleton<ForgetPasswordRepository>(
        () => ForgetPasswordRepositoryImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance<ForgetPasswordRepository>()));
  }

  Get.put<ForgetPasswordController>(ForgetPasswordController());
}

disposeForgetPassword() async {
  if (GetIt.I.isRegistered<ForgetPasswordDataSource>()) {
    instance.unregister<ForgetPasswordDataSource>();
  }

  if (GetIt.I.isRegistered<ForgetPasswordRepository>()) {
    instance.unregister<ForgetPasswordRepository>();
  }

  if (GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.unregister<ForgetPasswordUseCase>();
  }
}

initResetPasswordModule() {
  if (!GetIt.I.isRegistered<ResetPasswordRemoteDataSource>()) {
    instance.registerLazySingleton<ResetPasswordRemoteDataSource>(
      () => RemoteResetPasswordRemoteDataSourceImpl(
        instance<AppApi>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<ResetPasswordRepository>()) {
    instance.registerLazySingleton<ResetPasswordRepository>(
      () => ResetPasswordRepositoryImpl(
        instance<NetworkInfo>(),
        instance<ResetPasswordRemoteDataSource>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<ResetPasswordUseCase>()) {
    instance.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(
        instance<ResetPasswordRepository>(),
      ),
    );
  }

  Get.put<ResetPasswordController>(ResetPasswordController());
}

disposeResetPasswordModule() {
  disposeForgetPassword();
  if (GetIt.I.isRegistered<ResetPasswordRemoteDataSource>()) {
    instance.unregister<ResetPasswordRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<ResetPasswordRepository>()) {
    instance.unregister<ResetPasswordRepository>();
  }

  if (GetIt.I.isRegistered<ResetPasswordUseCase>()) {
    instance.unregister<ResetPasswordUseCase>();
  }

  Get.delete<ResetPasswordController>();
}

initSendOtp() async {
  if (!GetIt.I.isRegistered<RemoteSendOtpDataSource>()) {
    instance.registerLazySingleton<RemoteSendOtpDataSource>(
        () => RemoteSendOtpDataSourceImpl(instance<AppApi>()));
  }

  if (!GetIt.I.isRegistered<SendOtpRepository>()) {
    instance.registerLazySingleton<SendOtpRepository>(
        () => SendOtpRepositoryImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<SendOtpUseCase>()) {
    instance.registerFactory<SendOtpUseCase>(
        () => SendOtpUseCase(instance<SendOtpRepository>()));
  }
}

disposeSendOtp() async {
  if (GetIt.I.isRegistered<RemoteSendOtpDataSource>()) {
    instance.unregister<RemoteSendOtpDataSource>();
  }

  if (GetIt.I.isRegistered<SendOtpRepository>()) {
    instance.unregister<SendOtpRepository>();
  }

  if (GetIt.I.isRegistered<SendOtpUseCase>()) {
    instance.unregister<SendOtpUseCase>();
  }
}

initFcmToken() async {
  if (!GetIt.I.isRegistered<RemoteFcmTokenDataSource>()) {
    instance.registerLazySingleton<RemoteFcmTokenDataSource>(
        () => RemoteFcmTokenDataSourceImplement(instance<AppApi>()));
  }

  if (!GetIt.I.isRegistered<FcmTokenRepository>()) {
    instance.registerLazySingleton<FcmTokenRepository>(
        () => FcmTokenRepositoryImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<FcmTokenUseCase>()) {
    instance
        .registerFactory<FcmTokenUseCase>(() => FcmTokenUseCase(instance()));
  }
}

disposeFcmToken() async {
  if (GetIt.I.isRegistered<RemoteFcmTokenDataSource>()) {
    instance.unregister<RemoteFcmTokenDataSource>();
  }

  if (GetIt.I.isRegistered<FcmTokenRepository>()) {
    instance.unregister<FcmTokenRepository>();
  }

  if (GetIt.I.isRegistered<FcmTokenUseCase>()) {
    instance.unregister<FcmTokenUseCase>();
  }
}

initCourse() {
  initCoursesRating();
  initCourseDetails();
  initCoursesSubscription();
  initProfile();
}

disposeCourse() {
  disposeCourseDescription();
  disposeCourseRating();
  disposeCoursesSubscription();
  Get.delete<CourseDetailsController>();
  Get.delete<StepperController>();
}

initCourseDetails() {
  if (!GetIt.I.isRegistered<CourseDetailsDataSource>()) {
    instance.registerLazySingleton<CourseDetailsDataSource>(
        () => CourseDetailsDataSourceImplementation(instance()));
  }

  if (!GetIt.I.isRegistered<CourseDetailsRepository>()) {
    instance.registerLazySingleton<CourseDetailsRepository>(
      () => CourseDetailsRepositoryImplementation(
        instance(),
        instance(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<CourseDetailsUseCase>()) {
    instance.registerLazySingleton<CourseDetailsUseCase>(
      () => CourseDetailsUseCase(
        instance(),
      ),
    );
  }

  Get.put<CourseDetailsController>(CourseDetailsController());
}

disposeCourseDescription() async {
  if (GetIt.I.isRegistered<CourseDetailsDataSource>()) {
    instance.unregister<CourseDetailsDataSource>();
  }

  if (GetIt.I.isRegistered<CourseDetailsRepository>()) {
    instance.unregister<CourseDetailsRepository>();
  }

  if (GetIt.I.isRegistered<CourseDetailsUseCase>()) {
    instance.unregister<CourseDetailsUseCase>();
  }
}

initSubscriptionProcess() {
  initPaymentsModule();
  initCoursesSubscription();
  Get.put<StepperController>(StepperController());
}

initPaymentsModule() {
  if (!GetIt.I.isRegistered<RemotePaymentsDataSource>()) {
    instance.registerLazySingleton<RemotePaymentsDataSource>(
      () => RemotePaymentsDataSourceImplement(
        instance(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<PaymentsRepository>()) {
    instance.registerLazySingleton<PaymentsRepository>(
      () => PaymentsRepositoryImplementation(
        instance<RemotePaymentsDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<PaymentsUseCase>()) {
    instance.registerLazySingleton<PaymentsUseCase>(
      () => PaymentsUseCase(
        instance<PaymentsRepository>(),
      ),
    );
  }
}

initCoursesSubscription() {
  if (!GetIt.I.isRegistered<RemoteCourseSubscriptionDataSource>()) {
    instance.registerLazySingleton<RemoteCourseSubscriptionDataSource>(
      () => RemoteCourseSubscriptionDataSourceImplement(
        instance(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<CourseSubscriptionRepository>()) {
    instance.registerLazySingleton<CourseSubscriptionRepository>(
      () => CourseSubscriptionRepoImplement(
        instance(),
        instance(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<CourseSubscriptionUseCase>()) {
    instance.registerFactory<CourseSubscriptionUseCase>(
      () => CourseSubscriptionUseCase(
        instance<CourseSubscriptionRepository>(),
      ),
    );
  }
}

disposeCoursesSubscription() {
  if (GetIt.I.isRegistered<RemoteCourseSubscriptionDataSource>()) {
    instance.unregister<RemoteCourseSubscriptionDataSource>();
  }
  if (GetIt.I.isRegistered<CourseSubscriptionRepository>()) {
    instance.unregister<CourseSubscriptionRepository>();
  }

  if (GetIt.I.isRegistered<CourseSubscriptionUseCase>()) {
    instance.unregister<CourseSubscriptionUseCase>();
  }
}

initCoursesRating() {
  if (!GetIt.I.isRegistered<RemoteCourseRatingDataSource>()) {
    instance.registerLazySingleton<RemoteCourseRatingDataSource>(
      () => RemoteCourseRatingDataSourceImplement(
        instance(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<CourseRatingRepository>()) {
    instance.registerLazySingleton<CourseRatingRepository>(
      () => CourseRatingRepoImplement(
        instance(),
        instance(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<CourseRatingUseCase>()) {
    instance.registerLazySingleton<CourseRatingUseCase>(
      () => CourseRatingUseCase(
        instance(),
      ),
    );
  }
}

disposeCourseRating() {
  if (GetIt.I.isRegistered<RemoteCourseRatingDataSource>()) {
    instance.unregister<RemoteCourseRatingDataSource>();
  }

  if (GetIt.I.isRegistered<CourseRatingRepository>()) {
    instance.unregister<CourseRatingRepository>();
  }

  if (GetIt.I.isRegistered<CourseRatingUseCase>()) {
    instance.unregister<CourseRatingUseCase>();
  }
}
