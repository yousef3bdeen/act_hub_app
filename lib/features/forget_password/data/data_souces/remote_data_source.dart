import 'package:act_hub_app/core/network/app_api.dart';

import '../request/forget_password_request.dart';
import '../response/forget_password_response.dart';

abstract class ForgetPasswordDataSource {
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest);
}

class RemoteForgetPasswordDataSourceImpl implements ForgetPasswordDataSource {
  AppApi _appApi;

  RemoteForgetPasswordDataSourceImpl(this._appApi);

  @override
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) async {
    return await _appApi.forgetPassword(
      forgetPasswordRequest.email,
    );
  }
}
