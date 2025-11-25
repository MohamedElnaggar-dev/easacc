import 'package:flutter/material.dart';
import 'package:suits_app/core/utils/constants/app_dimensions.dart';

class AppStyles {
  AppStyles._();

  static String appFont = 'montserrat';

  static TextStyle reguler({
    double fontSize = AppDimensions.small,
    Color color = Colors.white,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: appFont,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color,
      decoration: textDecoration,
    );
  }

  static TextStyle medium({
    double fontSize = AppDimensions.medium,
    Color color = Colors.black,
    TextDecoration? textDecoration,
    double? height,
  }) {
    return TextStyle(
      fontFamily: appFont,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle semiBold({
    double fontSize = AppDimensions.medium,
    Color color = Colors.black,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: appFont,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
      decoration: textDecoration,
    );
  }

  static TextStyle bold({
    double fontSize = AppDimensions.medium,
    Color color = Colors.black,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: appFont,
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color,
      decoration: textDecoration,
    );
  }
}
