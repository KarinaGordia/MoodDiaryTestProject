import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: const CalendarWidget(),
    );
  }
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(model!.russianDaysOfWeek.length, (index) {
                return Text(
                  model.russianDaysOfWeek[index],
                  style: TextStyle(
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: const Color.fromRGBO(188, 188, 191, 1),
                  ),
                );
              }),
            ),
          ),
          ScrollCalendarWidget(),
        ],
      ),
    );
  }
}

class ScrollCalendarWidget extends StatelessWidget {
  const ScrollCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: List.generate(12, (index) {
            return CalendarMonthWidget(
              year: '2024',
              month: 'Январь',
            );
          }),
        ),
      ),
    );
  }
}

class CalendarMonthWidget extends StatelessWidget {
  const CalendarMonthWidget(
      {super.key, required this.year, required this.month});

  final String year;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            year,
            style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: const Color.fromRGBO(188, 188, 191, 1),
            ),
          ),
          Text(
            month,
            style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: const Color.fromRGBO(76, 76, 105, 1),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 205,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
