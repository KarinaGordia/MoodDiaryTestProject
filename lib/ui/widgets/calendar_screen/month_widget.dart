import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_description.dart';

class MonthWidget extends StatelessWidget {
  const MonthWidget(
      {super.key, required this.monthDate, required this.description});

  final DateTime monthDate;
  final MonthDescription description;

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider
        .watch(context)
        ?.model;

    return Padding(
      padding: description.monthWidgetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model!.isMonthlyFormat)
            GestureDetector(
              onTap: () {
                model.changeCalendarFormat();
                model.selectedYear = monthDate.year;
              },
              child: Text(
                DateFormat('yyyy').format(monthDate),
                style: TextStyle(
                  fontFamily: GoogleFonts
                      .nunito()
                      .fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: description.yearFontSize,
                  color: AppColors.grey2,
                ),
              ),
            ),
          Text(
            DateFormat('MMMM').format(monthDate),
            style: TextStyle(
              fontFamily: GoogleFonts
                  .nunito()
                  .fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: description.monthFontSize,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 10),
          DayCellBuilderWidget(
            cells: model.generateMonthCells(monthDate),
            month: monthDate.month,
            description: description,
          ),
        ],
      ),
    );
  }
 }
// class MonthWidget extends StatelessWidget {
//   const MonthWidget(
//       {super.key, required this.monthDate, required this.description});
//
//   final DateTime monthDate;
//   final MonthDescription description;
//
//   @override
//   Widget build(BuildContext context) {
//     final model = CalendarScreenWidgetModelProvider
//         .watch(context)
//         ?.model;
//
//     return DayCellBuilderWidget(
//       cells: model!.generateMonthCells(monthDate),
//       month: monthDate.month,
//       description: description,
//     );
//   }
// }

class DayCellBuilderWidget extends StatelessWidget {
  const DayCellBuilderWidget(
      {super.key, required this.cells, required this.month, required this.description});

  final List<DateTime> cells;
  final int month;
  final MonthDescription description;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 0,
          crossAxisSpacing: description.cellBuilderCrossAxisSpacing,
        ),
        itemCount: cells.length,
        itemBuilder: (context, index) {
          var item = cells[index];
          var isSameMonth = item.month == month;
          if (!isSameMonth) {
            return Container();
          }
          return DayCellWidget(
            date: item,
            description: description,
          );
        });
  }
}

class DayCellWidget extends StatelessWidget {
  const DayCellWidget({super.key, required this.date, required this.description});

  final DateTime date;
  final MonthDescription description;
  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider
        .watch(context)
        ?.model;
    final bool isToday = model?.today.compareTo(date) == 0;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if(model!.isMonthlyFormat) {
          model.selectDay(date);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (isToday && model!.isMonthlyFormat)
            Positioned(
              top:description.todayMarkGapFromCenter,
              child: Container(
                width:description.todayMarkSize,
                height:description.todayMarkSize,
                decoration: const BoxDecoration(
                  color: AppColors.mandarin,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          Text(
            date.day.toString(),
            style: TextStyle(
              fontFamily: GoogleFonts
                  .nunito()
                  .fontFamily,
              fontSize: description.dayFontSize,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          if (model?.selectedDay.compareTo(date) == 0)
            Container(
              margin: const EdgeInsets.all(1.5),
              decoration: const BoxDecoration(
                color: AppColors.mandarinTransparent,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
