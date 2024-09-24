import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mood_diary/app_icons.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/mood_diary_screen/mood_diary_widget.dart';
import 'package:mood_diary/ui/widgets/mood_diary_screen/mood_diary_widget_model.dart';
import 'package:mood_diary/ui/widgets/time_widget/time_widget.dart';
import 'package:mood_diary/ui/widgets/time_widget/time_widget_model.dart';

class EmotionScreenWidget extends StatefulWidget {
  const EmotionScreenWidget({super.key});

  @override
  State<EmotionScreenWidget> createState() => _EmotionScreenWidgetState();
}

class _EmotionScreenWidgetState extends State<EmotionScreenWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final _moodDiaryModel = MoodDiaryWidgetModel();
  final _timeWidgetModel = TimeWidgetModel();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeWidgetModel.updateTime();
    });

    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TimeWidgetModelProvider(
              model: _timeWidgetModel,
              child: const TimeWidget(),
            ),
            Container(
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 44),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(47.0),
                color: AppColors.grey4,
              ),
              child: TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  TabWidget(label:'Дневник настроения',icon: AppIcons.diary,),
                  TabWidget(label:'Статистика',icon: AppIcons.statistic,),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MoodDiaryWidgetModelProvider(
                    model: _moodDiaryModel,
                    child: const MoodDiaryWidget(),
                  ),
                  Center(
                    child: Text(
                      'Здесь будет отображаться ваша статистика',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 12,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(label),
        ],
      ),
    );
  }
}


