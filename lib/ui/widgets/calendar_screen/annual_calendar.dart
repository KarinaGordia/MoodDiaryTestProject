import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_description.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_widget.dart';

class AnnualCalendarWidget extends StatelessWidget {
  AnnualCalendarWidget({super.key, required this.year});

  final int? year;
  final monthDescription = AnnualCalendarMonthDescription();

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.watch(context)?.model;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '$year',
            style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily,
              fontWeight: FontWeight.w800,
              fontSize: 26,
              color: AppColors.black,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.05,
                mainAxisSpacing: 20,
                crossAxisSpacing: 35,),
              itemCount: CalendarScreenWidgetModel.monthsInYear,
              itemBuilder: (context, index) {
                var monthDate = DateTime(year!, index+1, 1);
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    model?.changeCalendarFormat();
                    model?.selectedMonthDate = monthDate;
                  },
                  child: MonthWidget(
                    monthDate: monthDate,
                    description: monthDescription,
                  ),
                );
              }),
        ),
      ],
    );
  }
}

