import '../../domain/models/profile_attributes_model.dart';
import '../response/profile_attributes_response.dart';
import 'package:act_hub_app/core/extensions/extensions.dart';

extension ProfileAttributesMapper on ProfileAttributesResponse {
  ProfileAttributesModel toDomain() => ProfileAttributesModel(
        name: name.onNull(),
        email: email.onNull(),
        phone: phone.onNull(),
        avatar: avatar.onNull(),
      );
}
