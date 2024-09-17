import 'package:flutter/material.dart';

class CalendarScreenWidgetModel {

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
