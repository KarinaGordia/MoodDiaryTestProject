import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';

class CalendarScreenWidget extends StatelessWidget {
  CalendarScreenWidget({super.key});

  final _model = CalendarScreenWidgetModel();

  @override
  Widget build(BuildContext context) {
    return CalendarScreenWidgetModelProvider(
      model: _model,
      child: const CalendarScreenWidgetBody(),
    );
  }
}

class CalendarScreenWidgetBody extends StatelessWidget {
  const CalendarScreenWidgetBody({
    super.key,
  });

  // @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CalendarScreenAppBarWidget(),
      body: CalendarWidget(),
    );
  }
}

class CalendarScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CalendarScreenAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    final scrollController = model?.scrollController;
    return AppBar(
      toolbarHeight: 52,
      leading: IconButton(
        style: const ButtonStyle(
          iconColor: WidgetStatePropertyAll(Color.fromRGBO(188, 188, 191, 1)),
        ),
        onPressed: () {
          Navigator.of(context).pop(context);
        },
        icon: const Icon(Icons.close_rounded),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: TextButton(
            style: const ButtonStyle(
              padding:
                  WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
            ),
            onPressed: () {
              scrollController?.animateTo(scrollController.initialScrollOffset,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear);
            },
            child: Text(
              'Сегодня',
              style: TextStyle(
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color.fromRGBO(188, 188, 191, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  CalendarScreenWidgetModel.russianDaysOfWeek.length, (index) {
                return Expanded(
                  child: Text(
                    CalendarScreenWidgetModel.russianDaysOfWeek[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: const Color.fromRGBO(188, 188, 191, 1),
                    ),
                  ),
                );
              }),
            ),
          ),
          const ScrollCalendarWidget(),
        ],
      ),
    );
  }
}

class ScrollCalendarWidget extends StatelessWidget {
  const ScrollCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    return Expanded(
      child: ListView.builder(
        controller: model?.scrollController,
        itemBuilder: (BuildContext context, int index) {
          var monthDate =
              DateTime(CalendarScreenWidgetModel.startingYear, index + 1, 1);
          return CalendarMonthWidget(
            monthDate: monthDate,
          );
        },
      ),
    );
  }
}

//пример календаря
//https://blog.jobins.jp/custom-calendar-in-flutter-application
class CalendarMonthWidget extends StatelessWidget {
  const CalendarMonthWidget({super.key, required this.monthDate});

  final DateTime monthDate;

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('yyyy').format(monthDate),
            style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: const Color.fromRGBO(188, 188, 191, 1),
            ),
          ),
          Text(
            DateFormat('MMMM').format(monthDate),
            style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: const Color.fromRGBO(76, 76, 105, 1),
            ),
          ),
          const SizedBox(height: 10),
          CellBuilderWidget(
            cells: model!.generateMonthCells(monthDate),
            month: monthDate.month,
          ),
        ],
      ),
    );
  }
}

class CellBuilderWidget extends StatelessWidget {
  const CellBuilderWidget(
      {super.key, required this.cells, required this.month});

  final List<DateTime> cells;
  final int month;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 0,
          crossAxisSpacing: 8,
        ),
        itemCount: cells.length,
        itemBuilder: (context, index) {
          var item = cells[index];
          var today = DateTime.now();
          var isToday = item.day == today.day &&
              item.month == today.month &&
              item.year == today.year;
          var isSameMonth = item.month == month;
          if(!isSameMonth) {
            return Container();
          }
          return CellWidget(
            index: index,
            isToday: isToday,
            isSameMonth: isSameMonth,
            date: item,
          );
        });
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget(
      {super.key,
      required this.index,
      required this.isToday,
      required this.isSameMonth,
      required this.date});

  final int index;
  final bool isToday;
  final bool isSameMonth;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.watch(context)?.model;
    return GestureDetector(
      onTap: () {
        model.selectDay(date);
      },
      child: Stack(
        children: <Widget>[
          if (isToday)
            Positioned(
              top: 35,
              left: 21,
              child: Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          Center(
            child: Text(
              date.day.toString(),
              style: TextStyle(
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(76, 76, 105, 1),
              ),
            ),
          ),
          if (model!.selectedDate?.compareTo(date) == 0)
            Container(
              margin: const EdgeInsets.all(1.5),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 135, 2, 0.25),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
