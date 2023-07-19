import 'package:act_hub_app/features/courses/domain/entity/course_subscription_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/use_case/base_use_case.dart';
import '../../data/repository/course_subscription_repo_impl.dart';
import '../../data/request/course_subscription_request.dart';

class CourseSubscriptionUseCase
    implements
        BaseUseCase<CourseSubscriptionRequest, CourseSubscriptionEntity> {
  final CourseSubscriptionRepository _repository;

  CourseSubscriptionUseCase(this._repository);

  @override
  Future<Either<Failure, CourseSubscriptionEntity>> execute(
      CourseSubscriptionRequest input) async {
    return await _repository.courseSubscription(
      CourseSubscriptionRequest(
        courseId: input.courseId,
        paymentMethodId: input.paymentMethodId,
      ),
    );
  }
}
