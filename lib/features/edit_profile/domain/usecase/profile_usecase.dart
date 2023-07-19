import 'package:act_hub_app/core/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../models/profile_model.dart';
import '../repository/profile_repository.dart';

class ProfileUseCase implements BaseOutUseCase<ProfileModel> {
  final ProfileRepository _repository;

  ProfileUseCase(this._repository);

  @override
  Future<Either<Failure, ProfileModel>> execute() async {
    return await _repository.profile();
  }
}
