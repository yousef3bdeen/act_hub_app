// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_course_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeCourseResponse _$AttributeCourseResponseFromJson(
        Map<String, dynamic> json) =>
    AttributeCourseResponse(
      title: json['name'] as String?,
      description: json['description'] as String?,
      active: json['active'] as int?,
      resourceId: json['resource_id'] as int?,
      hours: (json['hours'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
      avatar: json['avatar'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$AttributeCourseResponseToJson(
        AttributeCourseResponse instance) =>
    <String, dynamic>{
      'name': instance.title,
      'description': instance.description,
      'active': instance.active,
      'resource_id': instance.resourceId,
      'hours': instance.hours,
      'price': instance.price,
      'rate': instance.rate,
      'avatar': instance.avatar,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };
