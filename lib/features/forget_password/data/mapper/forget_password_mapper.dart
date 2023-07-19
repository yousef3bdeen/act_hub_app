import 'package:act_hub_app/core/extensions/extensions.dart';
import '../../domain/models/forget_password.dart';
import '../response/forget_password_response.dart';

extension ForgetPasswordMapper on ForgetPasswordResponse {
  toDomain() => ForgetPassword(
        status: status!.onNull(),
      );
}
