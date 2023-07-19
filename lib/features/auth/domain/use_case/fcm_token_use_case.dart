import 'package:act_hub_app/features/auth/domain/model/fcm_token_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/use_case/base_use_case.dart';
import '../../data/request/fcm_token_request.dart';
import '../repository/fcm_token_repository.dart';

class FcmTokenUseCaseInput {
  String? fcmToken;

  FcmTokenUseCaseInput({
    required this.fcmToken,
  });
}

class FcmTokenUseCase
    implements BaseUseCase<FcmTokenUseCaseInput, FcmTokenModel> {
  final FcmTokenRepository _fcmTokenRepository;

  FcmTokenUseCase(this._fcmTokenRepository);

  @override
  Future<Either<Failure, FcmTokenModel>> execute(
      FcmTokenUseCaseInput input) async {
    return await _fcmTokenRepository.sendFcmToken(
      FcmTokenRequest(
        fcmToken: input.fcmToken,
      ),
    );
  }
}
