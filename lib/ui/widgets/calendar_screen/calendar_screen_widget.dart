import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_diary/app_icons.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/annual_calendar.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/calendar_screen_widget_model.dart';
import 'package:mood_diary/ui/widgets/calendar_screen/monthly_calendar.dart';

class CalendarScreenWidget extends StatefulWidget {
  const CalendarScreenWidget({super.key});

  @override
  State<CalendarScreenWidget> createState() => _CalendarScreenWidgetState();
}

class _CalendarScreenWidgetState extends State<CalendarScreenWidget> {
  final _model = CalendarScreenWidgetModel();

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
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
      actions: const [
        AppBarTodayButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarTodayButton extends StatelessWidget {
  const AppBarTodayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = CalendarScreenWidgetModelProvider.read(context)?.model;
    return Padding(
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
            double? offset;
            offset = model.calculateOffsetBetweenMonths(model.selectedMonthDate!);
            model.monthController.animateTo(
              offset,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            model.selectDay(model.today);
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
    );
  }
}
