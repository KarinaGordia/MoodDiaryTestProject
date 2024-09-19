import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class CalendarDraftScreenWidgetBody extends StatelessWidget {
  CalendarDraftScreenWidgetBody({
    super.key,
  });
  final DateTime _today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52,
        leading: IconButton(
          style: const ButtonStyle(
            iconColor: WidgetStatePropertyAll(Color.fromRGBO(188, 188, 191, 1)),
          ),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
      var month = DateTime(_today.year-1, index + 1, 1);
      return ListTile(
        title: Text(DateFormat('MMMM yyyy').format(month)),
      );
    },
    ),
    );
  }
}
