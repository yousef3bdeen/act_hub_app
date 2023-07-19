import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants.dart';

part 'profile_attributes_response.g.dart';
@JsonSerializable()
class ProfileAttributesResponse  {
  @JsonKey(name: ApiConstants.name)
  String? name;
  @JsonKey(name: ApiConstants.email)
  String? email;
  @JsonKey(name: ApiConstants.phone)
  String? phone;
  @JsonKey(name: ApiConstants.avatar)
  String? avatar;

  ProfileAttributesResponse(
      {required this.name,
      required this.email,
      required this.phone,
      required this.avatar});

  factory ProfileAttributesResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileAttributesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileAttributesResponseToJson(this);
}
