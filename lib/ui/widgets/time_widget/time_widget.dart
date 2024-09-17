import 'package:flutter/material.dart';
import 'package:mood_diary/ui/widgets/time_widget/time_widget_model.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = TimeWidgetModelProvider.watch(context)?.model;
    return Padding(
      padding: const EdgeInsets.only(top:15, bottom: 10, left:20, right:20,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Text(
              '${model?.day} ${model?.russianMonth[model.monthIndex]} ${model?.time}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 24,
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              fixedSize: WidgetStateProperty.all(Size(24, 24)),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month,
              color: Color.fromRGBO(188, 188, 191, 1),
            ),
          ),
        ],
      ),
    );
  }
}