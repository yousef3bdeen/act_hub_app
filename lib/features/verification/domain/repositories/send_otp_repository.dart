import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../data/request/send_otp_request.dart';
import '../model/send_otp_model.dart';

abstract class SendOtpRepository{
  Future<Either<Failure,SendOtpModel>> sendOtp(SendOtpRequest sendOtpRequest);
}