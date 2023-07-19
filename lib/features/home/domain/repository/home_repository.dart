import 'package:act_hub_app/core/error_handler/error_handler.dart';
import 'package:act_hub_app/features/home/domain/model/home_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> home();
}
