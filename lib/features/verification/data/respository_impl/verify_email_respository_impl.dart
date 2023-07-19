import 'package:act_hub_app/config/constants.dart';
import 'package:act_hub_app/features/verification/data/mapper/verification_mapper.dart';
import 'package:act_hub_app/features/verification/data/request/verfification_request.dart';
import 'package:act_hub_app/features/verification/domain/model/verification_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/repositories/verification_repository.dart';
import '../data_source/remote_verification_data_source.dart';

class VerificationRepositoryImpl implements VerificationRepository {
  final RemoteVerificationDataSource _remoteVerificationDataSource;
  final NetworkInfo _networkInfo;

  VerificationRepositoryImpl(
      this._networkInfo, this._remoteVerificationDataSource);

  @override
  Future<Either<Failure, VerificationModel>> verifyEmail(
      VerificationRequest verifyEmailRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteVerificationDataSource
            .verification(verifyEmailRequest);
        if (response.status != null) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              ResponseCode.BAD_REQUEST.value,
              ManagerStrings.badRequest,
            ),
          );
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(
        Failure(
          ResponseCode.NO_INTERNET_CONNECTION.value,
          ApiConstants.noInternetConnection,
        ),
      );
    }
  }
}
