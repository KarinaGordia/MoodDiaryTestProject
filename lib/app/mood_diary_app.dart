import 'package:flutter/material.dart';
import 'package:mood_diary/theme/theme.dart';
import 'package:mood_diary/widgets/emotion_screen/emotion_screen_widget.dart';

class MoodDiaryApp extends StatelessWidget {
  const MoodDiaryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodDiaryApp',
      theme: appTheme,
      home: EmotionScreenWidget(),
    );
  }

}