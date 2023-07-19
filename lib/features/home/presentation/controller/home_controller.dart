import 'package:act_hub_app/config/dependency_injection.dart';
import 'package:act_hub_app/core/cache/cache.dart';
import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/home/domain/model/category_model.dart';
import 'package:act_hub_app/features/home/domain/usecase/home_usecase.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import '../../../../routes/routes.dart';
import '../../domain/model/course_model.dart';
import '../../domain/model/slider_model.dart';

class HomeController extends GetxController {
  late CarouselController carouselController;
  int selectedCategoryIndex = 0;
  int current = 0;

  List<SliderModel> sliders = [];

  List<CourseModel> popularCourses = [];

  List<CategoryModel> categories = [];

  final HomeUseCase _homeUseCase = instance<HomeUseCase>();

  CacheData cacheData = CacheData();

  @override
  void onInit() {
    super.onInit();
    home();
    carouselController = CarouselController();
  }

  void change(int index) {
    current = index;
    update();
  }

  setCurrentCourseId(int id) {
    cacheData.setCurrentCourseId(id);
  }

  performCategoryDetails(int index) {
    setCurrentCourseId(
      popularCourses[index].id.onNull(),
    );
    Navigator.pushNamed(Get.context!, Routes.courseDetailsView);
  }

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    update();
  }

  Future<void> home() async {
    BuildContext context = Get.context as BuildContext;
    (await _homeUseCase.execute()).fold((l) {
      dialogRender(
          context: context,
          stateRenderType: StateRenderType.popUpErrorState,
          message: l.message,
          title: '',
          retryAction: () {
            Get.back();
          });
    }, (r) {
      sliders = r.sliders!;
      categories = r.categories!;
      popularCourses = r.courses!;
      update();
    });
  }

  courseHoursFormat(int index) {
    return "${popularCourses[index].attributeCourseModel!.hours.toString()} hour";
  }
}
