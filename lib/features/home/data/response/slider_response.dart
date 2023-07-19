import 'package:json_annotation/json_annotation.dart';

import 'attribute_slider_response.dart';

part 'slider_response.g.dart';

@JsonSerializable()
class SliderResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'attributes')
  AttributeSliderResponse? attributeResponse;

  SliderResponse({
    this.id,
    this.type,
    this.attributeResponse,
  });

  factory SliderResponse.fromJson(Map<String, dynamic> json) =>
      _$SliderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SliderResponseToJson(this);
}
