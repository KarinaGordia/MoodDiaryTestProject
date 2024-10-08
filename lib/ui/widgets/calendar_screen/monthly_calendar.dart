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

  Widget _getList(bool isForward, DateTime date) {
        return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        final Widget child;
        var monthDate = isForward
            ? DateTime(date.year, date.month + index, 1)
            : DateTime(date.year, date.month - index, 1);
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

  void _getFixedHeight() {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    if(model?.yearTextKey.currentContext != null) {
      final RenderBox yearTextRenderBox = model?.yearTextKey.currentContext
          ?.findRenderObject() as RenderBox;
      final RenderBox monthTextRenderBox = model?.monthTextKey.currentContext
          ?.findRenderObject() as RenderBox;
      final RenderBox dayCellRenderBox = model?.dayCellKey.currentContext
          ?.findRenderObject() as RenderBox;
      model?.yearTextHeight = yearTextRenderBox.size.height;
      model?.monthTextHeight = monthTextRenderBox.size.height;
      model?.dayCellHeight = dayCellRenderBox.size.height;
    }
  }

  @override
  void initState() {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;

    if(model?.yearTextHeight == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>  _getFixedHeight());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    final selectedDate = model?.selectedMonthDate ?? model?.today;
    return Expanded(
      child: CustomScrollView(
        controller: model?.monthController,
        scrollDirection: Axis.vertical,
        anchor: 0,
        center: _initialMonth,
        slivers: <Widget>[
          _getList(false, selectedDate!),
          SliverToBoxAdapter(
            key: _initialMonth,
            child: MonthWidget(
              // key: model.todayMonthGlobalKey,
              monthDate: selectedDate,
              description: monthDescription,
            ),
          ),
          _getList(true, selectedDate),
        ],
      ),
    );
  }
}