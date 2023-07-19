import 'package:json_annotation/json_annotation.dart';

part 'attribute_course_response.g.dart';

@JsonSerializable()
class AttributeCourseResponse {
  @JsonKey(name: 'name')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'active')
  int? active;
  @JsonKey(name: 'resource_id')
  int? resourceId;
  @JsonKey(name: 'hours')
  double? hours;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'rate')
  double? rate;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;

  AttributeCourseResponse({
    this.title,
    this.description,
    this.active,
    this.resourceId,
    this.hours,
    this.price,
    this.rate,
    this.avatar,
    this.startDate,
    this.endDate,
  });

  factory AttributeCourseResponse.fromJson(Map<String, dynamic> json) =>
      _$AttributeCourseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeCourseResponseToJson(this);
}
