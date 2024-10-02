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
        const ScrollCalendarWidget(),
      ],
    );
  }
}

class ScrollCalendarWidget extends StatefulWidget {
  const ScrollCalendarWidget({super.key});

  @override
  State<ScrollCalendarWidget> createState() => _ScrollCalendarWidgetState();
}

class _ScrollCalendarWidgetState extends State<ScrollCalendarWidget> {
  final UniqueKey _center = UniqueKey();
  final monthDescription = MonthlyCalendarMonthDescription();
  //late final ScrollController _scrollController;

  Widget _getList(bool isForward, int year, int month) {
    return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        final Widget child;
        var monthDate = isForward
            ? DateTime(year, month + index, 1)
            : DateTime(year, month - index, 1);
        if (index == 0) {
          child = const SizedBox.shrink();
        } else {
          child = MonthWidget(
            monthDate: monthDate,
            description: monthDescription,
          );
        }
        return child;
      },
    );
  }

  // @override
  // void initState() {
  //   final model = CalendarScreenWidgetModelProvider.read(context)?.model;
  //   _scrollController = ScrollController(
  //     initialScrollOffset: model!.setMonthInitialScrollOffset(),
  //   );
  //   model.monthScrollController = _scrollController;
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    final startDate = model?.selectedMonthDate;
    return Expanded(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        anchor: 0,
        center: _center,
        slivers: <Widget>[
          _getList(false, startDate!.year, startDate.month),
          SliverToBoxAdapter(
            key: _center,
            child: MonthWidget(
              monthDate: startDate,
              description: monthDescription,
            ),
          ),
          _getList(true, startDate.year, startDate.month),
        ],
      ),
    );
  }
}