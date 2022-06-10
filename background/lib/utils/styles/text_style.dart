import 'package:background/utils/Constant.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/size_style.dart';
import 'package:flutter/material.dart';



class AppTextStyle{
  
  static TextStyle styleOnboardingTitle({Color textColor =  AppColor.neutralLight1}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextOnboarding,
          fontFamily: MyStrings.fontFamily,
          fontWeight: FontWeight.w700,
          color: textColor);

  static TextStyle styleTitle1({Color textColor =  AppColor.neutralLight1}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextTitle1,
          fontFamily: MyStrings.fontFamily,
          fontWeight: FontWeight.w700,
          color: textColor);

  static TextStyle styleTitle2({Color textColor = AppColor.neutralLight1}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextTitle2,
          fontFamily: MyStrings.fontFamily,
          fontWeight: FontWeight.w700,
          color: textColor);

  static TextStyle styleHeadline({Color textColor = AppColor.neutral1,}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextHeadline,
          fontFamily: MyStrings.fontFamily,
          fontWeight: FontWeight.w600,
          color: textColor);

  static TextStyle styleSubhead({Color textColor = AppColor.neutral1,FontWeight fontWeight = FontWeight.w400}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextCallOut,
          fontFamily: MyStrings.fontFamily,
          fontWeight:fontWeight,
          color: textColor);

  static TextStyle styleBody({Color textColor = AppColor.neutral1,FontWeight fontWeight = FontWeight.w400}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextBody,
          fontFamily: MyStrings.fontFamily,
          fontWeight: fontWeight,
          color: textColor);

  static TextStyle styleCallout({Color textColor = AppColor.neutral1,FontWeight fontWeight = FontWeight.w400}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextCallOut,
          fontFamily: MyStrings.fontFamily,
          fontWeight: fontWeight,
          color: textColor);

  static TextStyle styleFoodnote({Color textColor = AppColor.neutral1,FontWeight fontWeight = FontWeight.w400}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextFootnote,
          fontFamily: MyStrings.fontFamily,
          fontWeight: fontWeight,
          color: textColor);

  static TextStyle styleCaption1({Color textColor = AppColor.neutral1,FontWeight fontWeight = FontWeight.w400}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextCaption1,
          fontFamily: MyStrings.fontFamily,
          fontWeight: fontWeight,
          color: textColor);

  static TextStyle styleCaption2({Color textColor = AppColor.neutral1,FontWeight fontWeight = FontWeight.w400}) =>
      TextStyle(
          fontSize: SizeText.kSizeTextCaption2,
          fontFamily: MyStrings.fontFamily,
          fontWeight: fontWeight,
          color: textColor);

}

