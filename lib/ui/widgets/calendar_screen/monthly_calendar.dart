import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_description.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_widget.dart';

class MonthlyCalendarWidget extends StatelessWidget {
  const MonthlyCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    color: AppColors.grey2,
                  ),
                ),
              );
            }),
          ),
        ),
        ScrollCalendarWidget(),
      ],
    );
  }
}

class ScrollCalendarWidget extends StatelessWidget {
  ScrollCalendarWidget({super.key});

  final monthDescription = MonthlyCalendarMonthDescription();

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.watch(context)?.model;
    return Expanded(
      child: ListView.builder(
        controller: model?.monthScrollController,
        itemBuilder: (BuildContext context, int index) {
          var monthDate =
          DateTime(CalendarScreenWidgetModel.startingYear, index + 1, 1);
          return MonthWidget(
            monthDate: monthDate,
            description: monthDescription,
          );
        },
      ),
    );
  }
}