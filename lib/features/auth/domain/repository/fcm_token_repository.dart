import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../data/request/fcm_token_request.dart';
import '../model/fcm_token_model.dart';

abstract class FcmTokenRepository {
  Future<Either<Failure, FcmTokenModel>> sendFcmToken(FcmTokenRequest loginRequest);
}
