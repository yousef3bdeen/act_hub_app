import 'package:act_hub_app/features/home/data/response/attribute_category_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'attributes')
  AttributeCategoryResponse? attributeCategoryResponse;

  CategoryResponse({
    this.id,
    this.attributeCategoryResponse,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
