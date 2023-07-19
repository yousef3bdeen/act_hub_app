import 'package:act_hub_app/core/base_response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'category_response.dart';
import 'course_response.dart';
import 'slider_response.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'sliders')
  List<SliderResponse>? sliders;
  @JsonKey(name: 'categories')
  List<CategoryResponse>? categories;
  @JsonKey(name: 'courses')
  List<CourseResponse>? courses;

  HomeResponse({
    this.sliders,
    this.categories,
    this.courses,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}
