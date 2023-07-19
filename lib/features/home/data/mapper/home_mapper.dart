import 'package:act_hub_app/features/home/data/mapper/category_mapper.dart';
import 'package:act_hub_app/features/home/data/mapper/course_mapper.dart';
import 'package:act_hub_app/features/home/data/response/home_response.dart';
import 'package:act_hub_app/features/home/domain/model/home_model.dart';
import 'package:act_hub_app/features/home/data/mapper/slider_mapper.dart';

extension HomeMapper on HomeResponse{
  HomeModel toDomain(){
    return HomeModel(
      sliders: sliders?.map((e) => e.toDomain()).toList(),
      categories: categories?.map((e) => e.toDomain()).toList(),
      courses: courses?.map((e) => e.toDomain()).toList(),
    );
  }
}