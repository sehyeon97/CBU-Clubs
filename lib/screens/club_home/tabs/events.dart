import 'package:club/models/event_filters/event_semester.dart';
import 'package:club/models/event_filters/event_view.dart';
import 'package:club/providers/event_filter_provider.dart';
import 'package:club/widgets/events/calendar_view.dart';
import 'package:club/widgets/events/filter.dart';
import 'package:club/widgets/events/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Events extends ConsumerStatefulWidget {
  const Events({super.key});

  @override
  ConsumerState<Events> createState() => _EventsState();
}

class _EventsState extends ConsumerState<Events> {
  void rebuild(Semester semester, EventView view) {
    setState(() {
      ref.read(eventSemesterProvider.notifier).setSemester(semester);
      ref.read(eventViewProvider.notifier).setView(view);
    });
  }

  @override
  Widget build(BuildContext context) {
    Semester semester = ref.watch(eventSemesterProvider);
    EventView view = ref.watch(eventViewProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          FilterEvents(
            initalSemester: semester,
            initialView: view,
            rebuild: rebuild,
          ),
          if (view == EventView.calendar)
            const CalendarView()
          else
            const ViewAsList()
        ],
      ),
    );
  }
}
