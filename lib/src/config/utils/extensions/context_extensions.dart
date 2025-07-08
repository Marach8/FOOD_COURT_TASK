import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension ContextExtensions on BuildContext{
  double get screenWidth => MediaQuery.sizeOf(this).width;
  
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get inDarkMode => MediaQuery.platformBrightnessOf(this) == Brightness.dark;


  ProviderContainer get ref => ProviderScope.containerOf(this, listen: false);
}