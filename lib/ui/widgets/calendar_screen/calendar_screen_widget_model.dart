import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreenWidgetModel {
  final russianDaysOfWeek = <String>['ПН','ВТ','СР','ЧТ','ПТ','СБ','ВС'];

  List<DateTime> generateMonthCells(DateTime monthDate) {
    var cells = <DateTime>[];
    var month = monthDate.month;
    var year = monthDate.year;
    var totalDaysInMonth = DateUtils.getDaysInMonth(year, month);
    var firstDayDt = DateTime(year, month, 1);
    var previousMonthDt = firstDayDt.subtract(const Duration(days: 1));

    var firstDayOfWeek = firstDayDt.weekday;
    var previousMonthDays =
        DateUtils.getDaysInMonth(previousMonthDt.year, previousMonthDt.month);

    var previousMonthCells = List.generate(
        firstDayOfWeek - 1,
            (index) => DateTime(previousMonthDt.year, previousMonthDt.month,
            previousMonthDays - index));
    cells.addAll(previousMonthCells.reversed);

    List<DateTime> currentMonthCells = List.generate(totalDaysInMonth,
            (index) => DateTime(year, month, index + 1));
    cells.addAll(currentMonthCells);
    return cells;
  }
}

class CalendarScreenWidgetModelProvider extends InheritedWidget {
  final CalendarScreenWidgetModel model;
  const CalendarScreenWidgetModelProvider ({
    super.key,
    required this.model,
    required super.child,
  });

  static CalendarScreenWidgetModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CalendarScreenWidgetModelProvider>();
  }

    static CalendarScreenWidgetModelProvider? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<CalendarScreenWidgetModelProvider>()?.widget;
    return widget is CalendarScreenWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(CalendarScreenWidgetModelProvider oldWidget) {
    return true;
  }
}
