import 'package:json_annotation/json_annotation.dart';

part 'attribute_slider_response.g.dart';

@JsonSerializable()
class AttributeSliderResponse {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'id')
  String? id;

  AttributeSliderResponse({
    this.title,
    this.description,
    this.image,
    this.type,
    this.id,
  });

  factory AttributeSliderResponse.fromJson(Map<String, dynamic> json) =>
      _$AttributeSliderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeSliderResponseToJson(this);
}
