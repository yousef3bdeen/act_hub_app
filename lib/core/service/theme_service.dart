import 'package:act_hub_app/core/theme/manager_light_theme.dart';
import 'package:flutter/material.dart';
import '../theme/manager_dark_theme.dart';

class ThemeService {
  ThemeMode getThemeMode() => ThemeMode.light;

  ThemeData getThemeData() => managerLightThemeData();
}
