// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_data_attribute_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailsDataAttributeResponse _$CourseDetailsDataAttributeResponseFromJson(
        Map<String, dynamic> json) =>
    CourseDetailsDataAttributeResponse(
      name: json['name'] as String?,
      description: json['description'] as String?,
      active: json['active'] as int?,
      resourceId: json['resource_id'] as int?,
      hours: json['hours'] as int?,
      price: json['price'] as int?,
      rate: (json['rate'] as num?)?.toDouble(),
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$CourseDetailsDataAttributeResponseToJson(
        CourseDetailsDataAttributeResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'active': instance.active,
      'resource_id': instance.resourceId,
      'hours': instance.hours,
      'price': instance.price,
      'rate': instance.rate,
      'avatar': instance.avatar,
    };
