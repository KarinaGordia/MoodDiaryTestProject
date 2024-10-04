import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_diary/domain/entity/feeling.dart';
import 'package:mood_diary/ui/theme/theme.dart';
import 'package:mood_diary/ui/widgets/mood_diary_screen/mood_diary_widget_model.dart';
import 'package:mood_diary/ui/widgets/mood_diary_screen/slider_widget/slider_widget.dart';

class MoodDiaryWidget extends StatelessWidget {
  const MoodDiaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EmotionListViewWidget(),
                  EmotionSlider(
                    title: 'Уровень стресса',
                    minValueName: 'Низкий',
                    maxValueName: 'Высокий',
                  ),
                  EmotionSlider(
                    title: 'Самооценка',
                    minValueName: 'Неуверенность',
                    maxValueName: 'Уверенность',
                  ),
                  NotesWidget(title: 'Заметки'),
                ],
              ),
            ),
          ),
          SaveButton(),
        ],
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = MoodDiaryWidgetModelProvider.watch(context)?.model;
    final isDiaryFilled = model?.isDiaryFilled();
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20),
      child: FilledButton(
          style: ButtonStyle(
            backgroundColor: isDiaryFilled!
                ? const WidgetStatePropertyAll(AppColors.mandarin)
                : null,
          ),
          onPressed: isDiaryFilled
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Запись успешно сохранена!'),
                    ),
                  );
                  model?.resetSelection();
                }
              : null,
          child: const Text('Сохранить')),
    );
  }
}

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key, required this.title});

  final String title;

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    final model = MoodDiaryWidgetModelProvider.watch(context)?.model;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.labelLarge),
          Container(
            height: 90,
            padding: const EdgeInsets.all(10),
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
            child: TextField(
              controller: model?.textFieldController,
              minLines: null,
              maxLines: null,
              expands: true,
              style: Theme.of(context).textTheme.labelMedium,
              cursorColor: AppColors.black,
              decoration: InputDecoration.collapsed(
                  hintText: 'Введите заметку',
                  hintStyle: Theme.of(context).textTheme.headlineMedium),
              autofocus: false,
              onChanged: (value) {
                model?.noteText = value;
              },
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}

class EmotionListViewWidget extends StatefulWidget {
  const EmotionListViewWidget({super.key});

  @override
  State<EmotionListViewWidget> createState() => _EmotionListViewWidgetState();
}

class _EmotionListViewWidgetState extends State<EmotionListViewWidget> {
  @override
  Widget build(BuildContext context) {
    final model = MoodDiaryWidgetModelProvider.watch(context)?.model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Что чувствуешь?',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Container(
          height: 118,
          margin: const EdgeInsets.only(top: 12),
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              var feeling = model!.feelings[index];
              return FeelingButtonWidget(
                feeling: feeling,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 12,
              );
            },
          ),
        ),
        const SubFeelingsSectionWidget(),
      ],
    );
  }
}

class SubFeelingsSectionWidget extends StatelessWidget {
  const SubFeelingsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = MoodDiaryWidgetModelProvider.watch(context)?.model;
    bool isSubFeelingsEmpty = model!.subFeelings.isEmpty;

    return Container(
      padding: !isSubFeelingsEmpty
          ? const EdgeInsets.only(top: 15, right: 20)
          : null,
      child: Wrap(
        runAlignment: WrapAlignment.start,
        runSpacing: -4,
        spacing: 8,
        children: model.subFeelings.map((String subFeeling) {
          return SubFeelingWidget(
            subFeeling: subFeeling,
          );
        }).toList(),
      ),
    );
  }
}

class SubFeelingWidget extends StatefulWidget {
  const SubFeelingWidget({super.key, required this.subFeeling});

  final String subFeeling;

  @override
  State<SubFeelingWidget> createState() => _SubFeelingWidgetState();
}

class _SubFeelingWidgetState extends State<SubFeelingWidget> {
  @override
  Widget build(BuildContext context) {
    final model = MoodDiaryWidgetModelProvider.read(context)?.model;
    bool isSelected = model!.selectedSubFeelings.contains(widget.subFeeling);
    return FilterChip(
      visualDensity: const VisualDensity(
        vertical: -2,
      ),
      label: Text(widget.subFeeling),
      labelStyle: TextStyle(
        fontFamily: GoogleFonts.nunito().fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 11,
        color: isSelected ? AppColors.white : AppColors.black,
      ),
      selected: isSelected,
      onSelected: (bool value) {
        model.selectSubFeeling(widget.subFeeling, isSelected);
      },
    );
  }
}

class FeelingButtonWidget extends StatelessWidget {
  const FeelingButtonWidget({super.key, required this.feeling});

  final Feeling feeling;

  @override
  Widget build(BuildContext context) {
    final model = MoodDiaryWidgetModelProvider.watch(context)?.model;
    final border = feeling.isSelected
        ? Border.all(
            color: AppColors.mandarin,
            width: 2,
          )
        : null;

    return InkWell(
      onTap: () {
        model!.selectFeeling(feeling);
        model.getSubFeelingList();
      },
      borderRadius: BorderRadius.circular(76),
      child: Container(
        width: 83,
        height: 118,
        decoration: BoxDecoration(
          color: Colors.white,
          border: border,
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(76),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              feeling.imagePath,
              width: 53,
              height: 50,
            ),
            Text(
              feeling.name,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
