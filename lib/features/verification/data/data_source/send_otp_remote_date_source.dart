import 'package:act_hub_app/core/network/app_api.dart';
import '../request/send_otp_request.dart';
import '../response/send_otp_response.dart';

abstract class RemoteSendOtpDataSource {
  Future<SendOtpResponse> sendOtp(SendOtpRequest sendOtpRequest);
}

class RemoteSendOtpDataSourceImpl implements RemoteSendOtpDataSource {
  final AppApi _AppApi;

  RemoteSendOtpDataSourceImpl(this._AppApi);

  @override
  Future<SendOtpResponse> sendOtp(SendOtpRequest sendOtpRequest) async {
    return await _AppApi.sendOtp(
      sendOtpRequest.email,
    );
  }
}
