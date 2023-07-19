import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/courses/data/response/course_details_data_attribute_response.dart';
import 'package:act_hub_app/features/courses/domain/entity/course_details_data_attribute_entity.dart';

extension CourseDetailsDataAttributeMapper
    on CourseDetailsDataAttributeResponse {
  CourseDetailsDataAttributeEntity toDomain() {
    return CourseDetailsDataAttributeEntity(
      name: name.onNull(),
      description: description.onNull(),
      active: active.onNull(),
      resourceId: resourceId.onNull(),
      hours: hours.onNull(),
      price: price.onNull(),
      rate: rate.onNull(),
      avatar: avatar.onNull(),
    );
  }
}
