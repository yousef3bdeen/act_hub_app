import 'package:act_hub_app/features/courses/data/response/course_details_data_attribute_response.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants.dart';

part 'course_details_data_response.g.dart';

@JsonSerializable()
class CourseDetailsDataResponse {
  @JsonKey(name: Constants.courseId)
  int? id;
  @JsonKey(name: Constants.courseIsRated)
  bool? isRate;
  @JsonKey(name: Constants.courseUserRate)
  int? userRate;
  @JsonKey(name: Constants.courseAttributes)
  CourseDetailsDataAttributeResponse? courseDetailsDataAttributeResponse;

  CourseDetailsDataResponse({
   required this.id,
   required this.isRate,
   required this.userRate,
   required this.courseDetailsDataAttributeResponse,
  });

  factory CourseDetailsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CourseDetailsDataResponseToJson(this);
}
