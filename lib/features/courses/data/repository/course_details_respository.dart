import 'package:act_hub_app/config/constants.dart';
import 'package:act_hub_app/core/error_handler/error_handler.dart';
import 'package:act_hub_app/core/internet_checker/internet_checker.dart';
import 'package:act_hub_app/features/courses/data/data_source/course_details_data_source.dart';
import 'package:act_hub_app/features/courses/data/mapper/course_details_mapper.dart';
import 'package:act_hub_app/features/courses/data/request/course_details_request.dart';
import 'package:act_hub_app/features/courses/domain/entity/course_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CourseDetailsRepository {
  Future<Either<Failure, CourseDetailsEntity>> courseDetails(
      CourseDetailsRequest courseDetailsRequest);
}

class CourseDetailsRepositoryImplementation implements CourseDetailsRepository {
  final NetworkInfo _networkInfo;
  final CourseDetailsDataSource _detailsDataSource;

  CourseDetailsRepositoryImplementation(
    this._networkInfo,
    this._detailsDataSource,
  );

  @override
  Future<Either<Failure, CourseDetailsEntity>> courseDetails(
      CourseDetailsRequest courseDetailsRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _detailsDataSource.courseDetails(
          courseDetailsRequest,
        );
        return Right(response.toDomain());
      } catch (e) {
        return Left(
          ErrorHandler.handle(e).failure,
        );
      }
    } else {
      return Left(
        Failure(
          ResponseCode.NO_INTERNET_CONNECTION.value,
          ApiConstants.noInternetConnection,
        ),
      );
    }
  }
}
