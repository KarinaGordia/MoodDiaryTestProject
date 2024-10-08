import 'package:flutter/material.dart';

class CalendarScreenWidgetModel extends ChangeNotifier {
  CalendarScreenWidgetModel() {
    _selectedDay = today;
    selectedMonthDate = today;
    monthController = ScrollController();
  }

  static const monthsInYear = 12;

  static const russianDaysOfWeek = <String>[
    'ПН',
    'ВТ',
    'СР',
    'ЧТ',
    'ПТ',
    'СБ',
    'ВС'
  ];
  static const russianMonthNames = <String>[
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];

  Map<int, double> monthHeights = {};

  final _today = DateTime.now();

  DateTime get today => DateTime(_today.year, _today.month, _today.day);
  DateTime get currentMonth => DateTime(_today.year, _today.month);

  final yearTextKey = GlobalKey();
  final monthTextKey = GlobalKey();
  final dayCellKey = GlobalKey();

  late DateTime _selectedDay;
  DateTime get selectedDay => _selectedDay;

  DateTime? selectedMonthDate;

  int? selectedYear;

  bool _isMonthlyFormat = true;
  bool get isMonthlyFormat => _isMonthlyFormat;

  late final ScrollController monthController;
  double? yearTextHeight = 0;
  double? monthTextHeight = 0;
  double? dayCellHeight = 0;

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

  double calculateOffsetBetweenMonths(DateTime selected) {
    double totalOffset = 0;

    if(isCurrentMonth(selected)) return totalOffset;

    DateTime startDate = currentMonth.isBefore(selected) ? currentMonth : selected;
    DateTime endDate = currentMonth.isBefore(selected) ? selected : currentMonth;


    while (startDate.isBefore(endDate)) {
      int weeksInMonth = getWeeksInMonth(startDate);
      double monthHeight = calculateMonthHeight(weeksInMonth);
      totalOffset += monthHeight;

      startDate = DateTime(startDate.year, startDate.month + 1, 1);
    }

    return currentMonth.isBefore(selected) ? -totalOffset : totalOffset;
  }

  double calculateMonthHeight(int weeksInMonth) {
    final heightFromMap = monthHeights[weeksInMonth];
    if(monthHeights[weeksInMonth] != null) {
      return heightFromMap!;
    }

    double fixedHeight = yearTextHeight! + monthTextHeight! + 10 + 16;
    double monthHeight = fixedHeight + (weeksInMonth * dayCellHeight!);
    monthHeights[weeksInMonth] = monthHeight;
    return monthHeight;
  }

  int getWeeksInMonth(DateTime date) {
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    int firstDayWeekday = firstDayOfMonth.weekday;
    int daysInMonth = lastDayOfMonth.day;
    int totalDaysWithOffset = firstDayWeekday - 1 + daysInMonth;
    int weeks = (totalDaysWithOffset / 7).ceil();

    return weeks;
  }

  void selectDay(DateTime date) {
    _selectedDay = date;

    notifyListeners();
  }

  void changeCalendarFormat() {
    _isMonthlyFormat = !_isMonthlyFormat;
    if (_isMonthlyFormat) selectedMonthDate = null;

    notifyListeners();
  }

  bool isToday(DateTime date) {
    return today.compareTo(date) == 0;
  }

  bool isCurrentMonth(DateTime date) {
    return DateTime(today.year, today.month)
        .compareTo(DateTime(date.year, date.month)) ==
        0;
  }

  @override
  void dispose() {
    monthController.dispose();
    super.dispose();
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
