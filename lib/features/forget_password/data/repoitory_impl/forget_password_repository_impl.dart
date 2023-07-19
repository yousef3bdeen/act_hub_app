import 'package:act_hub_app/config/constants.dart';
import 'package:act_hub_app/features/forget_password/data/mapper/forget_password_mapper.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../domain/models/forget_password.dart';
import '../../domain/repositroy/forget_password_repositroy.dart';
import '../data_souces/remote_data_source.dart';
import '../request/forget_password_request.dart';

class ForgetPasswordRepositoryImpl extends ForgetPasswordRepository {
  final ForgetPasswordDataSource _forgetPasswordDataSource;
  final NetworkInfo _networkInfo;

  ForgetPasswordRepositoryImpl(
      this._networkInfo, this._forgetPasswordDataSource);

  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword(
      ForgetPasswordRequest forgetPasswordRequest) async {
    if (await _networkInfo.isConnected) {
      /// Its connected
      try {
        final response = await _forgetPasswordDataSource
            .forgetPassword(forgetPasswordRequest);
        return Right(response.toDomain());
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
