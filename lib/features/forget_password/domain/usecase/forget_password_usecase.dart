import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/use_case/base_use_case.dart';
import '../../data/request/forget_password_request.dart';
import '../models/forget_password.dart';
import '../repositroy/forget_password_repositroy.dart';

class ForgetPasswordUseCase
    implements BaseUseCase<ForgetPasswordInput, ForgetPassword> {
  final ForgetPasswordRepository _repository;

  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgetPassword>> execute(
      ForgetPasswordInput input) async {
    return await _repository.forgetPassword(
      ForgetPasswordRequest(
        email: input.email,
      ),
    );
  }
}

class ForgetPasswordInput {
  String email;

  ForgetPasswordInput({
    required this.email,
  });
}
