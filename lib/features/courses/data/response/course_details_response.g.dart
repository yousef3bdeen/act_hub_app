// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailsResponse _$CourseDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    CourseDetailsResponse(
      courseDetailsDataResponse: json['data'] == null
          ? null
          : CourseDetailsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    )..message = json['message'] as String?;

Map<String, dynamic> _$CourseDetailsResponseToJson(
        CourseDetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.courseDetailsDataResponse,
    };
