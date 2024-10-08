import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_description.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/month_widget.dart';

class AnnualCalendarWidget extends StatefulWidget {
  const AnnualCalendarWidget({
    super.key,
  });

  @override
  State<AnnualCalendarWidget> createState() => _AnnualCalendarWidgetState();
}

class _AnnualCalendarWidgetState extends State<AnnualCalendarWidget> {
  final monthDescription = AnnualCalendarMonthDescription();
  final UniqueKey _center = UniqueKey();

  Widget _getList(bool isForward, int year) {
    return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        final Widget child;
        if (index == 0) {
          child = const SizedBox.shrink();
        } else {
          child = YearWidget(
            year: isForward ? (year + index) : (year - index),
            monthDescription: monthDescription,
          );
        }
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      anchor: 0,
      center: _center,
      slivers: <Widget>[
        _getList(
          false,
          model!.selectedYear!,
        ),
        SliverToBoxAdapter(
          key: _center,
          child: YearWidget(
            year: model.selectedYear,
            monthDescription: monthDescription,
          ),
        ),
        _getList(
          true,
          model.selectedYear!,
        ),
      ],
    );
  }
}

class YearWidget extends StatelessWidget {
  const YearWidget(
      {super.key, required this.year, required this.monthDescription});

  final int? year;
  final MonthDescription monthDescription;

  @override
  Widget build(BuildContext context) {
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
        MonthGridViewWidget(
          year: year,
          monthDescription: monthDescription,
        ),
      ],
    );
  }
}

class MonthGridViewWidget extends StatelessWidget {
  const MonthGridViewWidget(
      {super.key, required this.year, required this.monthDescription});

  final int? year;
  final MonthDescription monthDescription;

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.watch(context)?.model;
    return GridView.builder(
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
          var monthDate = DateTime(year!, index + 1, 1);
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
        });
  }
}
