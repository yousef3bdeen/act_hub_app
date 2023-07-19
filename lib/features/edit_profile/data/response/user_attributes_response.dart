import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants.dart';
import '../../../../core/base_response/base_response.dart';

part 'user_attributes_response.g.dart';

@JsonSerializable()
class UserAttributesResponse extends BaseResponse{
  @JsonKey(name: ApiConstants.phone)
  String? phone;

  @JsonKey(name: ApiConstants.name)
  String? name;

  @JsonKey(name: ApiConstants.email)
  String? email;

  UserAttributesResponse({required this.phone, required this.name, required this.email});

  factory UserAttributesResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAttributesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesResponseToJson(this);
}


@JsonSerializable()
class AttributesUserResponse extends BaseResponse{
  @JsonKey(name: ApiConstants.attributes)
  UserAttributesResponse? attributes;


  AttributesUserResponse({required this.attributes});

  factory AttributesUserResponse.fromJson(Map<String, dynamic> json) =>
      _$AttributesUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesUserResponseToJson(this);
}



