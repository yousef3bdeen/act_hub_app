import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../models/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> profile();
}