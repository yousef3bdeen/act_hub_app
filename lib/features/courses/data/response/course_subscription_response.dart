import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants.dart';
import '../../../../core/base_response/base_response.dart';
part 'course_subscription_response.g.dart';

@JsonSerializable()
class CourseSubscriptionResponse extends BaseResponse{
  @JsonKey(name: ApiConstants.status)
  bool? status;

  CourseSubscriptionResponse({required this.status});

  factory CourseSubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseSubscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseSubscriptionResponseToJson(this);
}