import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarScreenWidget extends StatelessWidget {
  const CalendarScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52,
        leading: IconButton(
          style: const ButtonStyle(
            iconSize: WidgetStatePropertyAll(16),
            iconColor: WidgetStatePropertyAll(Color.fromRGBO(188, 188, 191, 1)),
          ),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: const Icon(Icons.close_rounded),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10)),
              ),
              onPressed: () {},
              child: Text('Сегодня',
                style: TextStyle(
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color.fromRGBO(188, 188, 191, 1),
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
