import 'package:act_hub_app/core/error_handler/error_handler.dart';
import 'package:act_hub_app/features/courses/data/data_source/course_subscription_data_source.dart';
import 'package:act_hub_app/features/courses/data/mapper/course_subscription_mapper.dart';
import 'package:act_hub_app/features/courses/data/request/course_subscription_request.dart';
import 'package:act_hub_app/features/courses/domain/entity/course_subscription_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/resources/manager_strings.dart';

abstract class CourseSubscriptionRepository {
  Future<Either<Failure, CourseSubscriptionEntity>> courseSubscription(
      CourseSubscriptionRequest courseSubscriptionRequest);
}

class CourseSubscriptionRepoImplement implements CourseSubscriptionRepository {
  final RemoteCourseSubscriptionDataSource _remoteCourseSubscriptionDataSource;
  final NetworkInfo _networkInfo;

  CourseSubscriptionRepoImplement(
    this._networkInfo,
    this._remoteCourseSubscriptionDataSource,
  );

  @override
  Future<Either<Failure, CourseSubscriptionEntity>> courseSubscription(
      CourseSubscriptionRequest courseSubscriptionRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteCourseSubscriptionDataSource
            .courseSubscription(courseSubscriptionRequest);
        return Right(
          response.toDomain(),
        );
      } catch (e) {
        return Left(
          ErrorHandler.handle(e).failure,
        );
      }
    } else {
      return Left(
        Failure(
          ResponseCode.NO_INTERNET_CONNECTION.value,
          ManagerStrings.NO_INTERNT_CONNECTION,
        ),
      );
    }
  }
}
