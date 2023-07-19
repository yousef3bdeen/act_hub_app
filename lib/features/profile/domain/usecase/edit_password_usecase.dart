import 'package:act_hub_app/features/profile/data/request/edit_password_request.dart';
import 'package:act_hub_app/features/profile/domain/model/edit_password_model.dart';
import 'package:act_hub_app/features/profile/domain/repository/edit_password_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/use_case/base_use_case.dart';

class EditPasswordUseCase
    implements BaseUseCase<EditPasswordRequest, EditPasswordModel> {
  final EditPasswordRepository _repository;

  EditPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, EditPasswordModel>> execute(
      EditPasswordRequest input) async {
    return await _repository.editPassword(EditPasswordRequest(
        password: input.password, confirmPassword: input.confirmPassword));
  }
}
