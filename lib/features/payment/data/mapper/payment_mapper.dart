import '../../domain/model/payment_model.dart';
import '../response/payment_response.dart';
import 'package:act_hub_app/core/extensions/extensions.dart';

extension PaymentMapper on PaymentResponse {
  PaymentModel toDomain() {
    return PaymentModel(
      id: id.onNull(),
      name: name.onNull(),
    );
  }
}
