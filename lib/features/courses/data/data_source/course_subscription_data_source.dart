import '../../../../core/network/app_api.dart';
import '../request/course_subscription_request.dart';
import '../response/course_subscription_response.dart';

abstract class RemoteCourseSubscriptionDataSource {
  Future<CourseSubscriptionResponse> courseSubscription(
      CourseSubscriptionRequest courseSubscriptionRequest);
}

class RemoteCourseSubscriptionDataSourceImplement
    implements RemoteCourseSubscriptionDataSource {
  final AppApi _appApi;

  RemoteCourseSubscriptionDataSourceImplement(this._appApi);

  @override
  Future<CourseSubscriptionResponse> courseSubscription(
      CourseSubscriptionRequest courseSubscriptionRequest) async {
    return await _appApi.courseSubscription(
      courseSubscriptionRequest.courseId,
      courseSubscriptionRequest.paymentMethodId,
    );
  }
}
