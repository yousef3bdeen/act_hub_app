// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeCategoryResponse _$AttributeCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    AttributeCategoryResponse(
      title: json['name'] as String?,
      description: json['description'] as String?,
      image: json['icon'] as String?,
      type: json['banner'] as String?,
    );

Map<String, dynamic> _$AttributeCategoryResponseToJson(
        AttributeCategoryResponse instance) =>
    <String, dynamic>{
      'name': instance.title,
      'description': instance.description,
      'icon': instance.image,
      'banner': instance.type,
    };
