import 'package:json_annotation/json_annotation.dart';

part 'course_details_data_attribute_response.g.dart';

@JsonSerializable()
class CourseDetailsDataAttributeResponse {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'active')
  int? active;
  @JsonKey(name: 'resource_id')
  int? resourceId;
  @JsonKey(name: 'hours')
  int? hours;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'rate')
  double? rate;
  @JsonKey(name: 'avatar')
  String? avatar;

  CourseDetailsDataAttributeResponse({
    required this.name,
    required this.description,
    required this.active,
    required this.resourceId,
    required this.hours,
    required this.price,
    required this.rate,
    required this.avatar,
  });

  factory CourseDetailsDataAttributeResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CourseDetailsDataAttributeResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CourseDetailsDataAttributeResponseToJson(this);
}
