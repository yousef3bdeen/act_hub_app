import 'package:act_hub_app/core/cache/cache.dart';
import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/core/storage/local/app_settings_shared_preferences.dart';
import 'package:act_hub_app/features/courses/data/request/course_details_request.dart';
import 'package:act_hub_app/features/courses/domain/mapper/course_details_mapper.dart';
import 'package:act_hub_app/features/courses/domain/usecase/course_details_usecase.dart';
import 'package:act_hub_app/routes/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import '../../../../config/dependency_injection.dart';
import '../../../../core/resources/manager_assets.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../edit_profile/domain/usecase/profile_usecase.dart';
import '../../data/request/course_rating_request.dart';
import '../../domain/usecase/course_rating_usecase.dart';
import '../model/course_details_model.dart';

class CourseDetailsController extends GetxController {
  final CourseDetailsUseCase _courseDetailsUseCase =
      instance<CourseDetailsUseCase>();
  late CourseDetailsModel _courseDetailsModel;
  String courseAvatar = '';
  String courseName = '';
  String courseDescription = '';
  String courseHourTraining = '';
  double courseRate = 0.0;
  bool courseIsRated = false;
  int ratingBarItemCount = 5;
  String price = '0.0';
  CacheData cacheData = CacheData();
  final ProfileUseCase _profileUseCase = instance<ProfileUseCase>();
  CourseRatingUseCase courseRatingUseCase = instance<CourseRatingUseCase>();

  final AppSettingsSharedPreferences _appSettingsPrefs =
      instance<AppSettingsSharedPreferences>();

  resetData() {
    courseAvatar = _courseDetailsModel
        .courseDetailsDataModel!.courseDetailsDataAttributeModel!.avatar
        .onNull();
    courseName = _courseDetailsModel
        .courseDetailsDataModel!.courseDetailsDataAttributeModel!.name
        .onNull();
    courseDescription = _courseDetailsModel
        .courseDetailsDataModel!.courseDetailsDataAttributeModel!.description
        .onNull();
    courseHourTraining = _courseDetailsModel
        .courseDetailsDataModel!.courseDetailsDataAttributeModel!.hours
        .onNull()
        .toString();
    courseRate = _courseDetailsModel
        .courseDetailsDataModel!.courseDetailsDataAttributeModel!.rate
        .onNull();
    courseIsRated = _courseDetailsModel.courseDetailsDataModel!.isRate.onNull();
    price = _courseDetailsModel
        .courseDetailsDataModel!.courseDetailsDataAttributeModel!.price
        .onNull()
        .toString();
    update();
  }

  bool isURLValid(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute;
  }

  ImageProvider<Object> image() {
    if (isURLValid(courseAvatar)) {
      return CachedNetworkImageProvider(courseAvatar);
    }

    return const AssetImage(
      ManagerAssets.course,
    );
  }

  readCourseDetails() async {
    BuildContext context = Get.context!;
    (await _courseDetailsUseCase.execute(
            CourseDetailsRequest(courseId: cacheData.getCurrentCourseId())))
        .fold((l) {
      dialogRender(
        context: context,
        stateRenderType: StateRenderType.popUpErrorState,
        message: l.message,
        title: '',
        retryAction: (){
          Get.offAllNamed(Routes.homeView);
        }
      );
    }, (r) {
      _courseDetailsModel = r.toDomain();
      cacheData.setCourseDetails(_courseDetailsModel);
      resetData();
    });
  }

  void courseRating({
    required BuildContext context,
    required double value,
  }) async {
    (await courseRatingUseCase.execute(
      CourseRatingRequest(
          courseId: cacheData.getCurrentCourseId(), value: value),
    ))
        .fold(
      (l) {
        courseRate = _courseDetailsModel
            .courseDetailsDataModel!.courseDetailsDataAttributeModel!.rate
            .onNull();
        dialogRender(
          context: context,
          message: ManagerStrings.courseRatingFailed,
          title: '',
          stateRenderType: StateRenderType.popUpErrorState,
          retryAction: () {
            Get.back();
          },
        );
      },
      (r) {
        dialogRender(
          context: context,
          message: ManagerStrings.courseRatingSuccessfully,
          title: '',
          stateRenderType: StateRenderType.popUpSuccessState,
          retryAction: () {
            Get.back();
          },
        );
      },
    );
  }

  readUserData() async {
    BuildContext context = Get.context!;
    dialogRender(
      context: context,
      message: ManagerStrings.loading,
      title: ManagerStrings.fetchingInformation,
      stateRenderType: StateRenderType.popUpLoadingState,
      retryAction: () {},
    );
    if (_appSettingsPrefs.getHasProfileData()) {
      Get.back();
      Navigator.pushNamed(context, Routes.paymentSelectionView);
    } else {
      (await _profileUseCase.execute()).fold((l) {
        Get.back();
        dialogRender(
            context: context,
            message: l.message,
            title: '',
            stateRenderType: StateRenderType.popUpErrorState,
            retryAction: () {
              Get.offAllNamed(Routes.homeView);
            });
      }, (r) {
        Get.back();
        _appSettingsPrefs.setEmail(r.data.attributes.email.onNull());
        _appSettingsPrefs.setUserName(r.data.attributes.name.onNull());
        _appSettingsPrefs.setUserPhone(r.data.attributes.phone.onNull());
        _appSettingsPrefs.setHasProfileData();
        Navigator.pushNamed(context, Routes.paymentSelectionView);
      });
    }
  }

  Future<void> paymentSelection(BuildContext context) async {
    await readUserData();
  }

  @override
  void onInit() {
    super.onInit();
    readCourseDetails();
  }
}
