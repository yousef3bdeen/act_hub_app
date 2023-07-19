// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_slider_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeSliderResponse _$AttributeSliderResponseFromJson(
        Map<String, dynamic> json) =>
    AttributeSliderResponse(
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AttributeSliderResponseToJson(
        AttributeSliderResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'id': instance.id,
    };
