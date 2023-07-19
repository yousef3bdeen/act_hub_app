import 'package:json_annotation/json_annotation.dart';

part 'attribute_category_response.g.dart';

@JsonSerializable()
class AttributeCategoryResponse {
  @JsonKey(name: 'name')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'icon')
  String? image;
  @JsonKey(name: 'banner')
  String? type;


  AttributeCategoryResponse({
    this.title,
    this.description,
    this.image,
    this.type,
  });

  factory AttributeCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AttributeCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeCategoryResponseToJson(this);
}
