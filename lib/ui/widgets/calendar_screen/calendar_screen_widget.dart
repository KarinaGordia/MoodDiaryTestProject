import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_diary/app_icons.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/annual_calendar.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/monthly_calendar.dart';

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
    final model = CalendarScreenWidgetModelProvider.watch(context)?.model;
    return Scaffold(
      appBar: const CalendarScreenAppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: model!.isMonthlyFormat
            ? const MonthlyCalendarWidget()
            : const AnnualCalendarWidget(),
      ),
    );
  }
}

class CalendarScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CalendarScreenAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    return AppBar(
      toolbarHeight: 52,
      leading: IconButton(
        style: const ButtonStyle(
          iconColor: WidgetStatePropertyAll(AppColors.grey2),
        ),
        onPressed: () {
          Navigator.of(context).pop(context);
        },
        icon: const Icon(
          AppIcons.union,
          size: 18,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: TextButton(
            style: const ButtonStyle(
              padding:
                  WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
            ),
            onPressed: () {
              if (!model!.isMonthlyFormat) {
                model.changeCalendarFormat();
              } else {
                if(model.todayMonthGlobalKey.currentContext != null) {
                  Scrollable.ensureVisible(model.todayMonthGlobalKey.currentContext!,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOut);
                }
              }
            },
            child: Text(
              'Сегодня',
              style: TextStyle(
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.grey2,
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
