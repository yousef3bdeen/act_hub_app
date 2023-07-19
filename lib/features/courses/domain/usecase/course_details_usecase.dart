import 'package:act_hub_app/core/use_case/base_use_case.dart';
import 'package:act_hub_app/features/courses/data/request/course_details_request.dart';
import 'package:act_hub_app/features/courses/domain/entity/course_details_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../data/repository/course_details_respository.dart';

class CourseDetailsUseCase
    implements BaseUseCase<CourseDetailsRequest, CourseDetailsEntity> {
  final CourseDetailsRepository _courseDetailsRepository;

  CourseDetailsUseCase(this._courseDetailsRepository);

  @override
  Future<Either<Failure, CourseDetailsEntity>> execute(
      CourseDetailsRequest courseDetailsRequest) async {
    return await _courseDetailsRepository.courseDetails(courseDetailsRequest);
  }
}
