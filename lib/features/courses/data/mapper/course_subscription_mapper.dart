import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/courses/domain/entity/course_subscription_entity.dart';
import '../response/course_subscription_response.dart';

extension CourseSubscriptionMapper on CourseSubscriptionResponse {
  CourseSubscriptionEntity toDomain() => CourseSubscriptionEntity(
        status: status.onNull(),
      );
}
