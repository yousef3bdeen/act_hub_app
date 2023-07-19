import 'package:act_hub_app/features/courses/domain/entity/course_rating_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/use_case/base_use_case.dart';
import '../../data/repository/course_rating_repo_impl.dart';
import '../../data/request/course_rating_request.dart';

class CourseRatingUseCase
    implements BaseUseCase<CourseRatingRequest, CourseRatingEntity> {
  final CourseRatingRepository _repository;

  CourseRatingUseCase(this._repository);

  @override
  Future<Either<Failure, CourseRatingEntity>> execute(
      CourseRatingRequest input) async {
    return await _repository.courseRating(
      CourseRatingRequest(
        courseId: input.courseId,
        value: input.value,
      ),
    );
  }
}
