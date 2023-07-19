import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/use_case/base_use_case.dart';
import '../../data/request/send_otp_request.dart';
import '../model/send_otp_model.dart';
import '../repositories/send_otp_repository.dart';

class SendOtpUseCase implements BaseUseCase<SendOtpInput, SendOtpModel> {
  final SendOtpRepository _repository;

  SendOtpUseCase(this._repository);

  @override
  Future<Either<Failure, SendOtpModel>> execute(SendOtpInput input) async {
    return await _repository.sendOtp(SendOtpRequest(email: input.email));
  }
}

class SendOtpInput {
  String email;

  SendOtpInput({required this.email});
}
