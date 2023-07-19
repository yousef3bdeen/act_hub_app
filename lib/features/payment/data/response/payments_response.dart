import 'package:act_hub_app/config/constants.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../core/base_response/base_response.dart';
import 'payment_response.dart';
part 'payments_response.g.dart';

@JsonSerializable()
class PaymentsResponse extends BaseResponse {
  @JsonKey(name: ApiConstants.data)
  List<PaymentResponse>? data;

  PaymentsResponse({
    required this.data,
  });

  factory PaymentsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsResponseToJson(this);
}
