import 'package:json_annotation/json_annotation.dart';
import '../../../../config/constants.dart';
import '../../../../core/base_response/base_response.dart';

part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse extends BaseResponse {
  @JsonKey(name: ApiConstants.id)
  int? id;
  String? name;

  PaymentResponse({
    required this.id,
    required this.name,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}
