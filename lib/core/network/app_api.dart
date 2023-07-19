import 'package:retrofit/http.dart';
import '../../config/constants.dart';
import 'package:dio/dio.dart';
import '../../config/request_constants.dart';
import '../../features/auth/data/response/fcm_token_response.dart';
import '../../features/auth/data/response/login_response.dart';
import '../../features/auth/data/response/register_response.dart';
import '../../features/courses/data/response/course_details_response.dart';
import '../../features/courses/data/response/course_rating_response.dart';
import '../../features/courses/data/response/course_subscription_response.dart';
import '../../features/edit_profile/data/response/profile_response.dart';
import '../../features/forget_password/data/response/forget_password_response.dart';
import '../../features/home/data/response/home_response.dart';
import '../../features/payment/data/response/payments_response.dart';
import '../../features/profile/data/response/edit_password_response.dart';
import '../../features/reset_password/data/response/reset_password_response.dart';
import '../../features/verification/data/response/send_otp_response.dart';
import '../../features/verification/data/response/verification_response.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AppApi {
  factory AppApi(
    Dio dio, {
    String baseUrl,
  }) = _AppApi;

  @POST(RequestConstants.login)
  Future<LoginResponse> login(
      @Field(ApiConstants.email) email, @Field(ApiConstants.password) password);

  @POST(RequestConstants.register)
  Future<RegisterResponse> register(
    @Field(ApiConstants.name) name,
    @Field(ApiConstants.email) email,
    @Field(ApiConstants.password) password,
    @Field(ApiConstants.passwordConfirmation) passwordConfirmation,
    @Field(ApiConstants.phone) phone,
  );

  @GET(RequestConstants.home)
  Future<HomeResponse> home();

  @POST(RequestConstants.emailVerification)
  Future<VerificationResponse> emailVerification(
    @Field(ApiConstants.verificationEmail) email,
    @Field(ApiConstants.otp) otp,
  );

  @POST(RequestConstants.forgetPasswordRequest)
  Future<ForgetPasswordResponse> forgetPassword(
    @Field(ApiConstants.email) String email,
  );

  @POST(RequestConstants.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Field(ApiConstants.email) email,
    @Field(ApiConstants.password) password,
    @Field(ApiConstants.otp) otp,
  );

  @POST(RequestConstants.sendOtp)
  Future<SendOtpResponse> sendOtp(
    @Field(ApiConstants.email) String email,
  );

  @POST(RequestConstants.fcmTokenUpdate)
  Future<FcmTokenResponse> sendFcmToken(
    @Field(ApiConstants.fcmToken) String? token,
  );

  @POST(RequestConstants.editPassword)
  Future<EditPasswordResponse> editPassword(
    @Field(ApiConstants.password) password,
    @Field(ApiConstants.passwordConfirmation) passwordConfirmation,
  );

  @POST(RequestConstants.courseDetails)
  Future<CourseDetailsResponse> courseDetails(
    @Field(ApiConstants.courseId) courseId,
  );

  @GET(RequestConstants.profile)
  Future<ProfileResponse> profile();

  @GET(RequestConstants.paymentMethods)
  Future<PaymentsResponse> paymentMethods();

  @POST(RequestConstants.courseSubscription)
  Future<CourseSubscriptionResponse> courseSubscription(
    @Field(ApiConstants.courseId) int courseId,
    @Field(ApiConstants.paymentMethodId) int paymentMethodId,
  );

  @POST(RequestConstants.courseRating)
  Future<CourseRatingResponse> courseRating(
    @Field(ApiConstants.courseId) int courseId,
    @Field(ApiConstants.value) double val,
  );
}
