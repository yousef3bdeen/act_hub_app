import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants.dart';
import '../../../../core/base_response/base_response.dart';
import 'profile_attributes_response.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse extends BaseResponse {
  @JsonKey(name: ApiConstants.data)
  ProfileResponseData? data;

  ProfileResponse({required this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class ProfileResponseData {
  @JsonKey(name: ApiConstants.type)
  String? type;
  @JsonKey(name: ApiConstants.id)
  int? id;
  @JsonKey(name: ApiConstants.attributes)
  ProfileAttributesResponse? attributes;

  ProfileResponseData({
    required this.id,
    required this.type,
    required this.attributes,
  });

  factory ProfileResponseData.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseDataToJson(this);
}
