import 'package:flutter/material.dart' show Radius;

class AppUIConstants {
  static double paddingBase = 4;

  static double marginBase = 4;

  static double minPadding = 4;
  static double mainHorizontalMargin = 16;

  static double subVerticalMargin = 12;
  static double subHorizontalMargin = 12;

  static double defaultPadding = 16;

  static double majorScalePadding(double scale) => scale * paddingBase;

  static double majorScaleMargin(double scale) => scale * marginBase;

  static double radioButtonSize = 20;
  static double svgSize = 24;
  static double miniIconSize = 16;
  static double subButtonHeight = 40;
  static Radius subButtonRadius = const Radius.circular(10);

  static double checkboxIconSize = 18;
  static double chipIconSizeInAgriculturalSupplyCard = 16;
  static double smallIconSizeInFarmerCard = 16;
  static double normalIconSizeInFarmerCard = 22;
  static double tinyIconSize = 14.67;

  static double boxBorderRadius = 8;
  static double dialogBorderRadius = 24;
}

class AppConstants {
  static const phoneNumberLength = 10;

  static const dateTimeDefaultFormat = 'dd/MM/yyyy';
  static const dateTimeRequestFormat = 'yyyy-MM-dd';
  static const timeRequestFormat = 'hh:mm';
  static const dateTimeCalendarEventFormat = 'MMMM, yyyy';
  static const dateTimeNotificationFormat = 'hh:mm | dd/MM/yyyy';
  static const dateTimeHistoryFormat = 'dd/MM/yyyy | HH:mm';
  static const time24hFormat = 'HH:mm';
  static const time12hFormat = 'hh:mm a';
  static const dateNameFormat = 'EEEE';
  static const dateTimeNoYearFormat = 'dd/MM';
  static const onlyShortMonthFormat = 'M';
}

class AppImageAsset {
  static String imagePlaceHolder = 'assets/images/placeholder.png';

  static String imageCat = 'assets/images/profile-cat.png';
}
