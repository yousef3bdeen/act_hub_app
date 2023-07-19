import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../model/payments_model.dart';

abstract class PaymentsRepository{
  Future<Either<Failure,PaymentsModel>> payments();
}
