import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/home/data/mapper/attribute_category_mapper.dart';
import '../../domain/model/category_model.dart';
import '../response/category_response.dart';

extension CategoryMapper on CategoryResponse {
  CategoryModel toDomain(){
    return CategoryModel(
      id: id.onNull(),
      attributeCategoryModel: attributeCategoryResponse?.toDomain(),
    );
  }
}