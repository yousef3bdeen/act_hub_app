import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/core/storage/local/app_settings_shared_preferences.dart';
import 'package:act_hub_app/features/courses/presentation/model/course_details_data_attribute_model.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../config/constants.dart';
import '../../../../config/dependency_injection.dart';
import '../../../../core/cache/cache.dart';
import '../../../../core/resources/manager_assets.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_fonts.dart';
import '../../../../core/resources/manager_sizes.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../routes/routes.dart';
import '../../../payment/domain/model/payment_model.dart';
import '../../../payment/domain/model/payments_model.dart';
import '../../../payment/domain/usecase/payments_usecase.dart';
import '../../data/request/course_subscription_request.dart';
import '../../domain/usecase/course_subscription_usecase.dart';
import '../view/widget/course_item.dart';

class StepperController extends GetxController {
  int currentStep = 0;
  int activeStep = 0;
  int stepsCount = 3;
  int firstStepIndex = 0;
  int secondStepIndex = 1;
  int lastStepIndex = 2;
  final AppSettingsSharedPreferences _appSettingsPrefs =
      instance<AppSettingsSharedPreferences>();
  CacheData cache = CacheData();
  List<EasyStep> steps = [];
  List<Widget> content = [];
  final PaymentsUseCase _paymentsUseCase = instance<PaymentsUseCase>();
  PaymentsModel _paymentsModel = PaymentsModel(
    data: [],
  );
  int paymentMethodId = -1;
  late PaymentModel _paymentModel = PaymentModel(id: 0, name: '');
  final CourseSubscriptionUseCase _courseSubscriptionUseCase =
      instance<CourseSubscriptionUseCase>();

  @override
  void onInit() {
    super.onInit();
    fillSteps();
    activeStep = currentStep;
  }

  Future<void> paymentMethods() async {
    BuildContext context = Get.context!;
    dialogRender(
      context: context,
      message: ManagerStrings.loading,
      title: ManagerStrings.fetchingInformation,
      stateRenderType: StateRenderType.popUpLoadingState,
      retryAction: () {},
    );
    if (!cache.getHasPaymentMethods()) {
      (await _paymentsUseCase.execute()).fold((l) {
        Get.back();
        dialogRender(
            context: context,
            message: l.message,
            title: '',
            stateRenderType: StateRenderType.popUpErrorState,
            retryAction: () {
              previousStep();
            });
      }, (r) {
        Get.back();
        _paymentsModel = r;
        cache.setPaymentMethods(_paymentsModel);
        cache.setHasPaymentMethods();
      });
    } else {
      Get.back();
    }
  }

  void onStepReached(index) {
    activeStep = index;
    currentStep = index;
    fillSteps();
    update();
  }

  Future<void> performPayment() async {
    BuildContext context = Get.context!;
    if (currentStep == lastStepIndex) {
      dialogRender(
          context: context,
          message: ManagerStrings.loading,
          title: '',
          stateRenderType: StateRenderType.popUpLoadingState,
          retryAction: () {});
      (await _courseSubscriptionUseCase.execute(
        CourseSubscriptionRequest(
          courseId: cache.getCurrentCourseId(),
          paymentMethodId: paymentMethodId,
        ),
      ))
          .fold(
        (l) {
          Get.back();
          dialogRender(
            context: context,
            message: l.message,
            title: '',
            stateRenderType: StateRenderType.popUpErrorState,
            retryAction: () {
              Get.back();
            },
          );
        },
        (r) {
          Get.back();
          showDialog(
              barrierDismissible: false,
              context: Get.context!,
              builder: (context) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w16,
                    vertical: ManagerHeight.h215,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ManagerHeight.h20,
                    horizontal: ManagerWidth.w16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      ManagerRadius.r8,
                    ),
                    color: ManagerColors.white,
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        ManagerAssets.submitPayment,
                        width: ManagerWidth.w48,
                        height: ManagerHeight.h48,
                      ),
                      SizedBox(height: ManagerHeight.h12),
                      Text(
                        ManagerStrings.paymentSuccessful,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s18,
                          color: ManagerColors.black,
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h8),
                      Text(
                        ManagerStrings.paymentRequest,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.greyLight,
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h16),
                      Spacer(),
                      mainButton(
                        minWidth: double.infinity,
                        height: ManagerHeight.h44,
                        onPressed: () => Get.offAllNamed(
                          Routes.mainView,
                        ),
                        child: Text(
                          ManagerStrings.confirm,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.white,
                          ),
                        ),
                        color: ManagerColors.primaryColor,
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: ManagerHeight.h16),
                    ],
                  ),
                );
              });
        },
      );
    } else {
      await nextStep();
    }
  }

  Future<void> nextStep() async {
    BuildContext context = Get.context!;
    if (currentStep < steps.length - 1) {
      if (!(currentStep == secondStepIndex && paymentMethodId == -1)) {
        await paymentMethods();
        fillContent();
        currentStep++;
        activeStep = currentStep;
        fillSteps();
        update();
      } else {
        dialogRender(
            context: context,
            message: ManagerStrings.pleaseSelectPaymentMethod,
            title: '',
            stateRenderType: StateRenderType.popUpErrorState,
            retryAction: () {
              Get.back();
            });
      }
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      activeStep = currentStep;
      fillSteps();
      update();
    }
  }

  fillSteps() {
    steps = [
      EasyStep(
        customStep: stepHeader(
          index: firstStepIndex,
          image: ManagerAssets.firstStepPayment,
        ),
        enabled: true,
      ),
      EasyStep(
        customStep: stepHeader(
          index: secondStepIndex,
          image: ManagerAssets.secondStepPayment,
        ),
        enabled: false,
      ),
      EasyStep(
        customStep: stepHeader(
          index: lastStepIndex,
          image: ManagerAssets.thirdStepPayment,
        ),
        enabled: false,
      ),
    ];
    fillContent();
    update();
  }

  void setPaymentMethod(int index) {
    paymentMethodId = _paymentsModel.data![index].id;
    _paymentModel = PaymentModel(
      id: paymentMethodId,
      name: _paymentsModel.data![index].name,
    );
    fillContent();
    update();
  }

  bool isCurrentPaymentMethod(int index) {
    return paymentMethodId == _paymentsModel.data![index].id;
  }

  fillContent() {
    CourseDetailsDataAttributeModel attribute = cache
        .getCourseDetails()
        .courseDetailsDataModel!
        .courseDetailsDataAttributeModel!;
    content = [
      Container(
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w20,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            courseItem(attribute),
            SizedBox(height: ManagerHeight.h20),
            Text(
              ManagerStrings.personalInformation,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: ManagerHeight.h20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    '${ManagerStrings.name} : ',
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
                  ),
                  Text(
                    _appSettingsPrefs.getUserName(),
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.greyLight,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    '${ManagerStrings.email} : ',
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
                  ),
                  Text(
                    _appSettingsPrefs.getEmail(),
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.greyLight,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    '${ManagerStrings.phone} : ',
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
                  ),
                  Text(
                    _appSettingsPrefs.getUserPhone(),
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.greyLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w20,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ManagerStrings.choosePayment,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: ManagerHeight.h20),
            SizedBox(
              height: ManagerHeight.h240,
              child: ListView.builder(
                itemCount: _paymentsModel.data!.length,
                itemBuilder: (context, index) {
                  return mainButton(
                    onPressed: () => setPaymentMethod(
                      index,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ManagerRadius.r10,
                        ),
                        color: ManagerColors.white,
                      ),
                      alignment: AlignmentDirectional.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w10,
                        vertical: ManagerHeight.h10,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: ManagerHeight.h10,
                      ),
                      height: ManagerHeight.h54,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ManagerAssets.cashPayment,
                            width: ManagerWidth.w36,
                            height: ManagerHeight.h36,
                          ),
                          SizedBox(width: ManagerWidth.w8),
                          Text(
                            _paymentsModel.data![index].name,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.greyLight,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: ManagerWidth.w16,
                            height: ManagerHeight.h16,
                            padding: EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w2,
                              vertical: ManagerHeight.h2,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: ManagerHeight.h1,
                                color: isCurrentPaymentMethod(index)
                                    ? ManagerColors.primaryColor
                                    : ManagerColors.paymentSelectorBorderSide,
                              ),
                              color: ManagerColors.transparent,
                            ),
                            child: isCurrentPaymentMethod(index)
                                ? Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ManagerColors.primaryColor,
                                    ),
                                  )
                                : Container(),
                          ),
                          SizedBox(width: ManagerWidth.w8),
                        ],
                      ),
                    ),
                    color: ManagerColors.transparent,
                    elevation: Constants.paymentElevation,
                    padding: EdgeInsets.zero,
                  );
                },
              ),
            )
          ],
        ),
      ),
      Container(
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w20,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ManagerHeight.h110,
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(
                  ManagerRadius.r10,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ManagerRadius.r10),
                    child: Image.network(
                      attribute.avatar.toString(),
                      width: ManagerWidth.w128,
                      height: ManagerHeight.h110,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: ManagerWidth.w10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w6,
                          vertical: ManagerHeight.h6,
                        ),
                        margin: EdgeInsets.only(
                          top: ManagerHeight.h6,
                        ),
                        decoration: BoxDecoration(
                          color: ManagerColors.backgroundCourses,
                          borderRadius: BorderRadius.circular(
                            ManagerRadius.r4,
                          ),
                        ),
                        child: Text(
                          ManagerStrings.design,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        attribute.name.toString(),
                        style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.black),
                      ),
                      SizedBox(
                        height: ManagerHeight.h10,
                      ),
                      Text(
                        courseHoursFormat(attribute.hours.onNull()),
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.only(
                      top: ManagerHeight.h10,
                      right: ManagerWidth.w10,
                      bottom: ManagerHeight.h10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(ManagerAssets.star),
                            Text(
                              ManagerStrings.rate,
                              style: getMediumTextStyle(
                                fontSize: ManagerFontSize.s12,
                                color: ManagerColors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h20),
            Text(
              ManagerStrings.personalInformation,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: ManagerHeight.h20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    '${ManagerStrings.name} : ',
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
                  ),
                  Text(
                    _appSettingsPrefs.getUserName(),
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.greyLight,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    '${ManagerStrings.email} : ',
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
                  ),
                  Text(
                    _appSettingsPrefs.getEmail(),
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.greyLight,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    '${ManagerStrings.phone} : ',
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
                  ),
                  Text(
                    _appSettingsPrefs.getUserPhone(),
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.greyLight,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h30),
            Container(
              alignment: AlignmentDirectional.centerStart,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ManagerStrings.choosePayment,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        ManagerRadius.r10,
                      ),
                      color: ManagerColors.white,
                    ),
                    alignment: AlignmentDirectional.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w10,
                      vertical: ManagerHeight.h10,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: ManagerHeight.h10,
                    ),
                    height: ManagerHeight.h54,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ManagerAssets.cashPayment,
                          width: ManagerWidth.w36,
                          height: ManagerHeight.h36,
                        ),
                        SizedBox(width: ManagerWidth.w8),
                        Text(
                          _paymentModel.name,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.greyLight,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: ManagerWidth.w16,
                          height: ManagerHeight.h16,
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w2,
                            vertical: ManagerHeight.h2,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: ManagerHeight.h1,
                                color: ManagerColors.primaryColor),
                            color: ManagerColors.transparent,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w8),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ];
    update();
  }


  courseHoursFormat(int hours) {
    return "$hours hour";
  }

  Container stepHeader({
    required int index,
    required String image,
  }) {
    return Container(
      width: ManagerWidth.w40,
      height: ManagerHeight.h40,
      padding: activeStep < index
          ? EdgeInsets.symmetric(
              horizontal: ManagerWidth.w12,
              vertical: ManagerHeight.h12,
            )
          : EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8,
              vertical: ManagerHeight.h8,
            ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: activeStep >= index ? ManagerColors.primaryColor : Colors.white,
        border: activeStep < index
            ? Border.all(
                width: ManagerWidth.w1_5,
                color: ManagerColors.greyLight,
              )
            : null,
      ),
      child: activeStep >= index
          ? SvgPicture.asset(
              image,
              width: ManagerWidth.w10,
              height: ManagerHeight.h10,
            )
          : Container(
              width: ManagerWidth.w2,
              height: ManagerHeight.h2,
              decoration: const BoxDecoration(
                color: ManagerColors.greyLight,
                shape: BoxShape.circle,
              ),
            ),
    );
  }
}
