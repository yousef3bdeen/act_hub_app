import 'package:act_hub_app/features/courses/presentation/model/course_details_data_attribute_model.dart';
import 'package:act_hub_app/features/courses/presentation/model/course_details_data_model.dart';

import '../../features/courses/presentation/model/course_details_model.dart';
import '../../features/payment/domain/model/payments_model.dart';

class CacheData {
  static String email = "";
  static String username = "";
  static String phone = "";
  static int currentCourseId = -1;
  static bool hasPayments = false;

  static PaymentsModel paymentsModel = PaymentsModel(
    data: [],
  );

  static CourseDetailsModel courseDetailsModel = CourseDetailsModel(
    courseDetailsDataModel: CourseDetailsDataModel(
      id: 0,
      isRate: false,
      userRate: 0,
      courseDetailsDataAttributeModel: CourseDetailsDataAttributeModel(
        name: '',
        description: '',
        active: 1,
        resourceId: -1,
        hours: 0,
        price: 0,
        rate: 0,
        avatar: '',
      ),
    ),
  );

  void setEmail(String value) {
    CacheData.email = value;
  }

  String getEmail() {
    return email;
  }

  void setUsername(String value) {
    CacheData.username = value;
  }

  String getUsername() {
    return username;
  }

  void setPhone(String value) {
    CacheData.phone = value;
  }

  String getPhone() {
    return phone;
  }

  void setCurrentCourseId(int value) {
    currentCourseId = value;
  }

  int getCurrentCourseId() {
    return currentCourseId;
  }

  bool getHasPaymentMethods() {
    return hasPayments;
  }

  void setHasPaymentMethods() {
    CacheData.hasPayments = true;
  }

  void setPaymentMethods(PaymentsModel paymentsModel) {
    CacheData.paymentsModel = paymentsModel;
  }

  PaymentsModel getPaymentMethods() {
    return paymentsModel;
  }

  void setCourseDetails(CourseDetailsModel courseDetailsModel) {
    CacheData.courseDetailsModel = courseDetailsModel;
  }

  CourseDetailsModel getCourseDetails() {
    return courseDetailsModel;
  }
}
