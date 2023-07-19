import 'package:act_hub_app/core/extensions/extensions.dart';
import '../../domain/model/attribute_course_model.dart';
import '../response/attribute_course_response.dart';

extension AttributeCourseMapper on AttributeCourseResponse {
  AttributeCourseModel toDomain() {
    return AttributeCourseModel(
      title: title.onNull(),
      description: description.onNull(),
      active: active.onNull(),
      resourceId: resourceId.onNull(),
      hours: hours.onNull(),
      price: price.onNull(),
      rate: rate.onNull(),
      avatar: avatar.onNull(),
      startDate: startDate.onNull(),
      endDate: endDate.onNull(),
    );
  }
}
