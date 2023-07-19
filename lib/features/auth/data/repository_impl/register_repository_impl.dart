import 'package:act_hub_app/config/constants.dart';
import 'package:act_hub_app/core/error_handler/error_handler.dart';
import 'package:act_hub_app/core/internet_checker/internet_checker.dart';
import 'package:act_hub_app/features/auth/data/data_source/remote_Register_data_source.dart';
import 'package:act_hub_app/features/auth/data/mapper/Register_mapper.dart';
import 'package:act_hub_app/features/auth/data/request/Register_request.dart';
import 'package:act_hub_app/features/auth/domain/model/Register.dart';
import 'package:act_hub_app/features/auth/domain/repository/register_repository.dart';
import 'package:dartz/dartz.dart';


class RegisterRepositoryImpl implements RegisterRepository {
  final RemoteRegisterDataSource _dataSource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl(this._dataSource, this.networkInfo);

  @override
  Future<Either<Failure, Register>> register(RegisterRequest registerRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await _dataSource.register(registerRequest);
        return Right(response.toDomain());
      } catch (e) {
        return Left(
          ErrorHandler.handle(e).failure,
        );
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
