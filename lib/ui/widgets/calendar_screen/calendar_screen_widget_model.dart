import 'package:flutter/material.dart';

class CalendarScreenWidgetModel extends ChangeNotifier {
  final _today = DateTime.now();
  get today => DateTime(_today.year, _today.month, _today.day);

  late final ScrollController _scrollController;
  ScrollController get monthScrollController => _scrollController;

  late DateTime _selectedDate;
  get selectedDate => _selectedDate;

  int? selectedYear;

  bool _isMonthlyFormat = true;
  bool get isMonthlyFormat => _isMonthlyFormat;

  CalendarScreenWidgetModel() {
    _selectedDate = today;
    _scrollController = ScrollController(
      initialScrollOffset: setInitialScrollOffset(today.year, today.month),
    );
  }

  static const startingYear = 2023;
  static const monthsInYear = 12;
  static const averageMonthWidgetHeight = 320;
  static const russianDaysOfWeek = <String>[
    'ПН',
    'ВТ',
    'СР',
    'ЧТ',
    'ПТ',
    'СБ',
    'ВС'];

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

    List<DateTime> currentMonthCells = List.generate(
        totalDaysInMonth, (index) => DateTime(year, month, index + 1));
    cells.addAll(currentMonthCells);
    return cells;
  }

  double setInitialScrollOffset(int year, int month) {
    int yearsBetween = year - startingYear;
    int monthsCount = yearsBetween * monthsInYear + month - 1;
    return (monthsCount * averageMonthWidgetHeight).toDouble();
  }

  void selectDay(DateTime date) {
    _selectedDate = date;

    notifyListeners();
  }

  void changeCalendarFormat() {
    _isMonthlyFormat = !_isMonthlyFormat;
    print('Format was changed');
    notifyListeners();
  }
}

class CalendarScreenWidgetModelProvider extends InheritedNotifier {
  final CalendarScreenWidgetModel model;

  const CalendarScreenWidgetModelProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static CalendarScreenWidgetModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        CalendarScreenWidgetModelProvider>();
  }

  static CalendarScreenWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            CalendarScreenWidgetModelProvider>()
        ?.widget;
    return widget is CalendarScreenWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(CalendarScreenWidgetModelProvider oldWidget) {
    return true;
  }
}
