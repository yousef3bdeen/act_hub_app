import 'package:act_hub_app/core/extensions/extensions.dart';
import '../../domain/model/send_otp_model.dart';
import '../response/send_otp_response.dart';

extension SendOtpMapper on SendOtpResponse {
  toDomain() => SendOtpModel(status: status?.onNull());
}
