import 'package:act_hub_app/core/error_handler/error_handler.dart';
import 'package:act_hub_app/features/auth/data/request/Register_request.dart';
import 'package:act_hub_app/features/auth/domain/model/Register.dart';
import 'package:dartz/dartz.dart';


abstract class RegisterRepository {
  Future<Either<Failure, Register>> register(RegisterRequest registerRequest);
}
