import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_description.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_widget.dart';

class AnnualCalendarWidget extends StatefulWidget {
  const AnnualCalendarWidget({super.key, required this.year,});

  final int? year;

  @override
  State<AnnualCalendarWidget> createState() => _AnnualCalendarWidgetState();
}

class _AnnualCalendarWidgetState extends State<AnnualCalendarWidget> {
  final monthDescription = AnnualCalendarMonthDescription();
  late final ScrollController _scrollController;

  double _calculateInitialScrollOffset() {
    return ((widget.year! - CalendarScreenWidgetModel.startingYear) *
        CalendarScreenWidgetModel.yearWidgetHeight ).toDouble();
  }

  @override
  void initState() {
    _scrollController = ScrollController(
      initialScrollOffset: _calculateInitialScrollOffset(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider
        .watch(context)
        ?.model;
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        int year = CalendarScreenWidgetModel.startingYear + index;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '$year',
                style: TextStyle(
                  fontFamily: GoogleFonts
                      .nunito()
                      .fontFamily,
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                  color: AppColors.black,
                ),
              ),
            ),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.05,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 35,
                ),
                itemCount: CalendarScreenWidgetModel.monthsInYear,
                itemBuilder: (context, index) {
                  var monthDate = DateTime(year, index + 1, 1);
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
          ],
        );
      },
    );
  }
}
