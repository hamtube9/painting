import 'package:background/utils/Constant.dart';
import 'package:background/utils/styles/color_style.dart';
import 'package:background/utils/styles/size_style.dart';
import 'package:flutter/material.dart';



class AppTextStyle{
  
  static TextStyle styleOnboardingTitle({Color textColor =  AppColor.neutral1}) =>
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

class DefaultTextStyle extends TextStyle {
  const DefaultTextStyle(
      {Color? color, FontWeight? fontWeight, double? fontSize})
      : super(
      fontFamily: MyStrings.fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight);
}

class NormalTextStyle extends DefaultTextStyle {
  const NormalTextStyle({Color? color, double? fontSize})
      : super(fontSize: fontSize, color: color, fontWeight: FontWeight.normal);
}

class MediumTextStyle extends DefaultTextStyle {
  const MediumTextStyle({Color? color, double? fontSize})
      : super(fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
}

class BoldTextStyle extends DefaultTextStyle {
  const BoldTextStyle({Color? color, double? fontSize})
      : super(fontSize: fontSize, color: color, fontWeight: FontWeight.bold);
}

class TextStyles {
  static const double title1Fontsize = 28;
  static const double title2Fontsize = 22;
  static const double headlineFontsize = 17;
  static const double subheadFontsize = 15;
  static const double calloutFontsize = 16;
  static const double bodyFontsize = 17;
  static const double footnoteFontsize = 13;
  static const double caption1Fontsize = 12;
  static const double caption2Fontsize = 11;

  static const title1 =
  BoldTextStyle(color: ThemeColors.neutral1, fontSize: title1Fontsize);
  static const title2 =
  BoldTextStyle(color: ThemeColors.neutral1, fontSize: title2Fontsize);

  static const headline =
  NormalTextStyle(color: ThemeColors.neutral1, fontSize: headlineFontsize);
  static const headlineMedium =
  MediumTextStyle(color: ThemeColors.neutral1, fontSize: headlineFontsize);

  static const subhead =
  NormalTextStyle(color: ThemeColors.neutral1, fontSize: subheadFontsize);
  static const subheadMedium =
  MediumTextStyle(color: ThemeColors.neutral1, fontSize: subheadFontsize);
  static const subheadBold =
  BoldTextStyle(color: ThemeColors.neutral1, fontSize: subheadFontsize);

  static const callout =
  NormalTextStyle(color: ThemeColors.neutral1, fontSize: calloutFontsize);
  static const calloutMedium =
  MediumTextStyle(color: ThemeColors.neutral1, fontSize: calloutFontsize);
  static const calloutBold =
  BoldTextStyle(color: ThemeColors.neutral1, fontSize: calloutFontsize);

  static const body =
  NormalTextStyle(color: ThemeColors.neutral1, fontSize: bodyFontsize);
  static const bodyMedium =
  MediumTextStyle(color: ThemeColors.neutral1, fontSize: bodyFontsize);
  static const bodyBold =
  BoldTextStyle(color: ThemeColors.neutral1, fontSize: bodyFontsize);

  static const footnote =
  NormalTextStyle(color: ThemeColors.neutral1, fontSize: footnoteFontsize);
  static const footnoteMedium =
  MediumTextStyle(color: ThemeColors.neutral1, fontSize: footnoteFontsize);
  static const footnoteBold =
  BoldTextStyle(color: ThemeColors.neutral1, fontSize: footnoteFontsize);

  static const caption1 =
  NormalTextStyle(color: ThemeColors.neutral1, fontSize: caption1Fontsize);
  static const caption1Medium =
  MediumTextStyle(color: ThemeColors.neutral1, fontSize: caption1Fontsize);
  static const caption1Bold =
  BoldTextStyle(color: ThemeColors.neutral1, fontSize: caption1Fontsize);

  static const caption2 =
  NormalTextStyle(color: ThemeColors.neutral1, fontSize: caption2Fontsize);
  static const caption2Medium =
  MediumTextStyle(color: ThemeColors.neutral1, fontSize: caption2Fontsize);
  static const caption2Bold =
  BoldTextStyle(color: ThemeColors.neutral1, fontSize: caption2Fontsize);
}

