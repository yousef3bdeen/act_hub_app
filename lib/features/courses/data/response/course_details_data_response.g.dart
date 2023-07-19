// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailsDataResponse _$CourseDetailsDataResponseFromJson(
        Map<String, dynamic> json) =>
    CourseDetailsDataResponse(
      id: json['id'] as int?,
      isRate: json['isRated'] as bool?,
      userRate: json['user_rate'] as int?,
      courseDetailsDataAttributeResponse: json['attributes'] == null
          ? null
          : CourseDetailsDataAttributeResponse.fromJson(
              json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseDetailsDataResponseToJson(
        CourseDetailsDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isRated': instance.isRate,
      'user_rate': instance.userRate,
      'attributes': instance.courseDetailsDataAttributeResponse,
    };
