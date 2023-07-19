import '../../../../core/network/app_api.dart';
import '../request/course_rating_request.dart';
import '../response/course_rating_response.dart';

abstract class RemoteCourseRatingDataSource{
  Future<CourseRatingResponse> courseRating(CourseRatingRequest courseRatingRequest);
}

class RemoteCourseRatingDataSourceImplement implements RemoteCourseRatingDataSource {
  final AppApi _appApi;

  RemoteCourseRatingDataSourceImplement(this._appApi);

  @override
  Future<CourseRatingResponse> courseRating(CourseRatingRequest courseRatingRequest) async{
    return await _appApi.courseRating(courseRatingRequest.courseId, courseRatingRequest.value);
  }
}