import '../../../../core/network/app_api.dart';
import '../request/reset_password_request.dart';
import '../response/reset_password_response.dart';

abstract class ResetPasswordRemoteDataSource {
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
}

class RemoteResetPasswordRemoteDataSourceImpl implements ResetPasswordRemoteDataSource {
  final AppApi _appApi;

  RemoteResetPasswordRemoteDataSourceImpl(this._appApi);

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    return await _appApi.resetPassword(
      resetPasswordRequest.email,
      resetPasswordRequest.password,
      resetPasswordRequest.otp,
    );
  }
}
