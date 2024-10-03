import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget.dart';

class TimeWidgetModel extends ChangeNotifier {
  var day = DateTime.now().day;
  var monthIndex = DateTime.now().month;
  static const russianMonthsInGenitiveCase = <int, String>{
    1:'января',
    2:'февраля',
    3:'марта',
    4:'апреля',
    5:'мая',
    6:'июня',
    7:'июля',
    8:'августа',
    9:'сентября',
    10:'октября',
    11:'ноября',
    12:'декабря',
  };

  var time = DateFormat.Hm().format(DateTime.now());

  void updateTime() {
    day = DateTime.now().day;
    monthIndex = DateTime.now().month;
    time = DateFormat.Hm().format(DateTime.now());
    notifyListeners();
  }

  void showCalendar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CalendarScreenWidget(),
      ),
    );
  }
}

class TimeWidgetModelProvider extends InheritedNotifier {
  final TimeWidgetModel model;

  const TimeWidgetModelProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static TimeWidgetModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        TimeWidgetModelProvider>();
  }

  static TimeWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TimeWidgetModelProvider>()
        ?.widget;
    return widget is TimeWidgetModelProvider ? widget : null;
  }
}
