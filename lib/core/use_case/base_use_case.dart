import 'package:act_hub_app/core/error_handler/error_handler.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}

abstract class BaseOutUseCase<Out> {
  Future<Either<Failure, Out>> execute();
}
