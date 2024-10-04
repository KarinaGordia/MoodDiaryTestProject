import 'package:flutter/material.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/mood_diary_screen/mood_diary_widget_model.dart';
import 'package:mood_diary/ui/widgets/mood_diary_screen/slider_widget/custom_thumb.dart';
import 'package:mood_diary/ui/widgets/mood_diary_screen/slider_widget/custom_track.dart';

class EmotionSlider extends StatefulWidget {
  const EmotionSlider({
    super.key,
    required this.title,
    required this.minValueName,
    required this.maxValueName,
  });

  final String title;
  final String minValueName;
  final String maxValueName;

  @override
  State<EmotionSlider> createState() => _EmotionSliderState();
}

class _EmotionSliderState extends State<EmotionSlider> {


  @override
  Widget build(BuildContext context) {
    final model = MoodDiaryWidgetModelProvider.watch(context)?.model;
    final isFeelingSelected = model?.selectedFeelings.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Container(
            height: 77,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: Offset(2, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 2,
                        height: 8,
                        color: AppColors.grey5,
                      );
                    }),
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackShape: CustomTrackShape(),
                    overlayShape: SliderComponentShape.noOverlay,
                    trackHeight: 6,
                    thumbShape:
                    const CircleThumbShape(thumbRadius: 9, borderWidth: 4),
                    thumbColor: AppColors.mandarin,
                    disabledThumbColor: AppColors.grey5,
                  ),
                  child: Slider(
                    value: model!.sliderCurrentValue,
                    activeColor: AppColors.mandarin,
                    inactiveColor: AppColors.grey5,
                    max: 1,
                    allowedInteraction: SliderInteraction.tapAndSlide,
                    onChanged: isFeelingSelected! ? (value) {
                      setState(() {
                        model.sliderCurrentValue = value;
                      });
                    } : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.minValueName,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        widget.maxValueName,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}