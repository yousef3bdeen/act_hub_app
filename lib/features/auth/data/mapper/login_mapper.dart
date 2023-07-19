import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/auth/data/response/login_response.dart';
import '../../domain/model/login.dart';

extension LoginMapper on LoginResponse {
  toDomain() {
    return Login(token: token.onNull());
  }
}