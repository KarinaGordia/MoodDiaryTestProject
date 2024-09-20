import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';
import 'package:mood_diary/ui/widgets/time_widget/calendar_draft.dart';

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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CalendarScreenAppBarWidget(),
      body: CalendarWidget(),
    );
  }
}

class CalendarScreenAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CalendarScreenAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 10)),
            ),
            onPressed: () {},
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
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
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
              children: List.generate(model!.russianDaysOfWeek.length, (index) {
                return Expanded(
                  child: Text(
                    model.russianDaysOfWeek[index],
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

class ScrollCalendarWidget extends StatefulWidget {
  const ScrollCalendarWidget({super.key});

  @override
  State<ScrollCalendarWidget> createState() => _ScrollCalendarWidgetState();
}

class _ScrollCalendarWidgetState extends State<ScrollCalendarWidget> {
  final DateTime _today = DateTime.now();

  final ScrollController scrollController = ScrollController(
    // initialScrollOffset: 50,
    // keepScrollOffset: true,
  );

  //вычислить индекс начального виджета на основе текущего месяца
  //высоту смогу найти только после построения яйчеек
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          var monthDate = DateTime(_today.year, index + 1, 1);
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
  const CalendarMonthWidget(
      {super.key,  required this.monthDate});

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
            month: monthDate,
          ),
        ],
      ),
    );
  }
}

class CellBuilderWidget extends StatelessWidget {
  const CellBuilderWidget({super.key, required this.cells, required this.month});
  final List<DateTime> cells;
  final DateTime month;

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
          var isSameMonth = item.month == month.month;
          return Opacity(
            opacity: isSameMonth ? 1 : 0,
            child: Center(
              child: Text(
                item.day.toString(),
                style: TextStyle(
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(76, 76, 105, 1),),
              ),
            ),
          );
        });
  }
}