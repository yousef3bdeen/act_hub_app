import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/courses/domain/entity/course_rating_entity.dart';
import '../response/course_rating_response.dart';

extension CourseRatingMapper on CourseRatingResponse {
  CourseRatingEntity toDomain() => CourseRatingEntity(
        status: status.onNull(),
      );
}
