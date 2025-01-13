// Semester: can select either Fall or Spring
// View: can either select 'calendar' view or 'list' view
// the list view will show only the dates that are marked as events

import 'package:club/data/screen_size.dart';
import 'package:club/models/event_filters/event_semester.dart';
import 'package:club/models/event_filters/event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterEvents extends ConsumerStatefulWidget {
  const FilterEvents({
    super.key,
    required this.initalSemester,
    required this.initialView,
    required this.rebuild,
  });

  final Semester initalSemester;
  final EventView initialView;
  final void Function(Semester semester, EventView view) rebuild;

  @override
  ConsumerState<FilterEvents> createState() => _FilterEventsState();
}

class _FilterEventsState extends ConsumerState<FilterEvents> {
  @override
  Widget build(BuildContext context) {
    Semester semester = widget.initalSemester;
    EventView view = widget.initialView;

    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          showDragHandle: true,
          enableDrag: true,
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  height: Device.screenSize.height * 0.65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                          child: Text(
                        'View Options',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                      const SizedBox(height: 24.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text('Select Semester'),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(27, 211, 211, 211),
                          ),
                          child: Column(
                            children: [
                              RadioListTile<Semester>(
                                value: Semester.fall,
                                groupValue: semester,
                                onChanged: (Semester? value) {
                                  setState(() {
                                    semester = value!;
                                  });
                                },
                                title: const Text('Fall'),
                              ),
                              RadioListTile<Semester>(
                                value: Semester.spring,
                                groupValue: semester,
                                onChanged: (Semester? value) {
                                  setState(() {
                                    semester = value!;
                                  });
                                },
                                title: const Text('Spring'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 48.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text('View as'),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(27, 211, 211, 211),
                          ),
                          child: Column(
                            children: [
                              RadioListTile<EventView>(
                                value: EventView.calendar,
                                groupValue: view,
                                onChanged: (EventView? value) {
                                  setState(() {
                                    view = value!;
                                  });
                                },
                                title: const Text('Calendar'),
                              ),
                              RadioListTile<EventView>(
                                value: EventView.list,
                                groupValue: view,
                                onChanged: (EventView? value) {
                                  setState(() {
                                    view = value!;
                                  });
                                },
                                title: const Text('List'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28.0),
                      Center(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 3, 125, 224)),
                          ),
                          onPressed: () {
                            widget.rebuild(semester, view);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Submit changes',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            widget.rebuild(Semester.fall, EventView.calendar);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Reset to default'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: const Text('View Options'),
    );
  }
}
