import 'package:flutter/cupertino.dart';

abstract class MonthDescription {
  late double? yearFontSize;
  late double monthFontSize;
  late double cellBuilderCrossAxisSpacing;
  late double todayMarkSize;
  late double todayMarkGapFromCenter;
  late double dayFontSize;
  late EdgeInsetsGeometry monthWidgetPadding;
}

class MonthlyCalendarMonthDescription implements MonthDescription {
  @override
  double? yearFontSize = 16;
  @override
  double monthFontSize = 24;
  @override
  double cellBuilderCrossAxisSpacing = 8;
  @override
  double todayMarkSize = 5;
  @override
  double todayMarkGapFromCenter = 35;
  @override
  double dayFontSize = 18;

  @override
  EdgeInsetsGeometry monthWidgetPadding = const EdgeInsets.only(bottom: 16);


}

class AnnualCalendarMonthDescription implements MonthDescription {
  @override
  double monthFontSize = 14;
  @override
  double cellBuilderCrossAxisSpacing = 3.5;
  @override
  double todayMarkSize = 3;
  @override
  double todayMarkGapFromCenter = 35;
  @override
  double dayFontSize = 10;

  @override
  double? yearFontSize;

  @override
  EdgeInsetsGeometry monthWidgetPadding = EdgeInsets.zero;


}