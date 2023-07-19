import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/verification/data/response/verification_response.dart';
import 'package:act_hub_app/features/verification/domain/model/verification_model.dart';

extension VerificationMapper on VerificationResponse {
  VerificationModel toDomain() {
    return VerificationModel(
      status: status.onNull(),
    );
  }
}
