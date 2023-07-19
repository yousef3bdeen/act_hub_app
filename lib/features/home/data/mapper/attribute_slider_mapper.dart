import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:act_hub_app/features/home/data/response/attribute_slider_response.dart';
import 'package:act_hub_app/features/home/domain/model/attribute_slider_model.dart';

extension AttributeSliderMapper on AttributeSliderResponse {
  AttributeSliderModel toDomain() {
    return AttributeSliderModel(
      title: title.onNull(),
      description: description.onNull(),
      image: image.onNull(),
      type: type.onNull(),
      id: id.onNull(),
    );
  }
}
