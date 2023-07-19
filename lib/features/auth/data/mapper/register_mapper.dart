import 'package:act_hub_app/core/extensions/extensions.dart';
import '../../domain/model/Register.dart';
import '../response/register_response.dart';

extension RegisterMapper on RegisterResponse {
  toDomain() {
    return Register(status: status.onNull());
  }
}
