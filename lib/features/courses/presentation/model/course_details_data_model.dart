import 'course_details_data_attribute_model.dart';

class CourseDetailsDataModel {
  int? id;
  bool? isRate;
  int? userRate;
  CourseDetailsDataAttributeModel? courseDetailsDataAttributeModel;

  CourseDetailsDataModel({
   required this.id,
   required this.isRate,
   required this.userRate,
   required this.courseDetailsDataAttributeModel,
  });
}
