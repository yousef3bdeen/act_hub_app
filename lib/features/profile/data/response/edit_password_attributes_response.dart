import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants.dart';
import '../../../../core/base_response/base_response.dart';

part 'edit_password_attributes_response.g.dart';
@JsonSerializable()
class EditPasswordAttributesResponse  {
  @JsonKey(name: ApiConstants.name)
  String? name;
  @JsonKey(name: ApiConstants.email)
  String? email;
  @JsonKey(name: ApiConstants.phone)
  String? phone;
  @JsonKey(name: ApiConstants.avatar)
  String? avatar;

  EditPasswordAttributesResponse(
      {required this.name,
      required this.email,
      required this.phone,
      required this.avatar});

  factory EditPasswordAttributesResponse.fromJson(Map<String, dynamic> json) =>
      _$EditPasswordAttributesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditPasswordAttributesResponseToJson(this);
}
