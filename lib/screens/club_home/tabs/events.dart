import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: today,
      firstDay: DateTime(
        today.year,
        today.month,
        today.day,
      ),
      lastDay: DateTime(
        today.year,
        today.month,
        today.day + 30,
      ),
      calendarFormat: CalendarFormat.month,
      onDaySelected: (selectedDay, focusedDay) {},
    );
  }
}
