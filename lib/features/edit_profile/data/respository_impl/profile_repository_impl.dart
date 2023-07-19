import 'package:act_hub_app/features/edit_profile/data/mapper/profile_mapper.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../domain/models/profile_model.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_remote_data_source.dart';

class ProfileRepoImplement implements ProfileRepository {
  final RemoteProfileDataSource _remoteProfileDataSource;
  final NetworkInfo _networkInfo;

  ProfileRepoImplement(this._networkInfo, this._remoteProfileDataSource);

  @override
  Future<Either<Failure, ProfileModel>> profile() async {
    if (await _networkInfo.isConnected) {
      /// Its connected
      try {
        final response = await _remoteProfileDataSource.profile();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION.value,
          ManagerStrings.NO_INTERNT_CONNECTION));
    }
  }
}
