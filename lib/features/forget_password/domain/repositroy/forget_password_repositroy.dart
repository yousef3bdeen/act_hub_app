import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../data/request/forget_password_request.dart';
import '../models/forget_password.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failure, ForgetPassword>> forgetPassword(
    ForgetPasswordRequest forgetPasswordRequest,
  );
}
