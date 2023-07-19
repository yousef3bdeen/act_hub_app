import 'package:act_hub_app/core/base_response/base_response.dart';
import 'package:act_hub_app/features/courses/data/response/course_details_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_details_response.g.dart';

@JsonSerializable()
class CourseDetailsResponse extends BaseResponse {
  @JsonKey(name: 'data')
  CourseDetailsDataResponse? courseDetailsDataResponse;

  CourseDetailsResponse({required this.courseDetailsDataResponse});

  factory CourseDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CourseDetailsResponseToJson(this);
}
