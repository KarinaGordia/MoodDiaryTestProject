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
  final UniqueKey _initialMonth = UniqueKey();
  final monthDescription = MonthlyCalendarMonthDescription();
  late final ScrollController _scrollController;

  Widget _getList(bool isForward, DateTime date) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
        return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        final Widget child;
        var monthDate = isForward
            ? DateTime(date.year, date.month + index, 1)
            : DateTime(date.year, date.month - index, 1);
        if (index == 0) {
          child = const SizedBox.shrink();
        } else {
          bool isToday = monthDate.compareTo(DateTime(model!.today.year, model.today.month)) == 0;
          child = MonthWidget(
            key: isToday ? model.todayMonthGlobalKey : null,
            monthDate: monthDate,
            description: monthDescription,
          );
        }
        return child;
      },
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    final startDate = model?.selectedMonthDate ?? model?.today;
    final isToday = model?.isToday(startDate!);

    return Expanded(
      child: CustomScrollView(
        cacheExtent: 9999,
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        anchor: 0,
        center: _initialMonth,
        slivers: <Widget>[
          _getList(false, startDate!),
          SliverToBoxAdapter(
            key: _initialMonth,
            child: MonthWidget(
              key: isToday! ? model?.todayMonthGlobalKey : null,
              monthDate: startDate,
              description: monthDescription,
            ),
          ),
          _getList(true, startDate),
        ],
      ),
    );
  }
}