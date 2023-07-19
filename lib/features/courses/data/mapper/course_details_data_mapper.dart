import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/courses/data/mapper/course_details_data_attribute_mapper.dart';
import 'package:act_hub_app/features/courses/data/response/course_details_data_response.dart';
import 'package:act_hub_app/features/courses/domain/entity/course_details_data_entity.dart';

extension CourseDetailsDataMapper on CourseDetailsDataResponse {
  CourseDetailsDataEntity toDomain() {
    return CourseDetailsDataEntity(
      id: id.onNull(),
      isRate: isRate.onNull(),
      userRate: userRate.onNull(),
      courseDetailsDataAttributeEntity:
          courseDetailsDataAttributeResponse?.toDomain(),
    );
  }
}
