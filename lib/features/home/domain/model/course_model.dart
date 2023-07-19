import 'attribute_course_model.dart';

class CourseModel {
  int? id;
  bool? isRated;
  double? userRate;
  AttributeCourseModel? attributeCourseModel;

  CourseModel({
    this.id,
    this.isRated,
    this.userRate,
    this.attributeCourseModel,
  });
}
