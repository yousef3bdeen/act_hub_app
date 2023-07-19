import 'package:act_hub_app/core/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../model/payments_model.dart';
import '../repository/payments_repository.dart';

class PaymentsUseCase implements BaseOutUseCase<PaymentsModel> {
  final PaymentsRepository _repository;

  PaymentsUseCase(this._repository);

  @override
  Future<Either<Failure, PaymentsModel>> execute() async {
    return await _repository.payments();
  }
}
