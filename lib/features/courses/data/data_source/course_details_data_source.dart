import 'package:act_hub_app/core/network/app_api.dart';
import 'package:act_hub_app/features/courses/data/request/course_details_request.dart';

import '../response/course_details_response.dart';

abstract class CourseDetailsDataSource {
  Future<CourseDetailsResponse> courseDetails(
    CourseDetailsRequest courseDetailsRequest,
  );
}

class CourseDetailsDataSourceImplementation extends CourseDetailsDataSource {
  final AppApi _appApi;

  CourseDetailsDataSourceImplementation(this._appApi);

  @override
  Future<CourseDetailsResponse> courseDetails(
      CourseDetailsRequest courseDetailsRequest) async {
    return await _appApi.courseDetails(courseDetailsRequest.courseId);
  }
}
