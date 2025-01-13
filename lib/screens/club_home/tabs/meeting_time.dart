import 'package:flutter/material.dart';

class MeetingTime extends StatefulWidget {
  const MeetingTime({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MeetingTimeState();
  }
}

// implement two things:
// 1) a time range showing the recommended time frame given the submitted schedules
// 2) the decided meeting time by the president (zero if not decided)
// 3) a button for user to submit the pdf version of their schedule
// 4) a popup for any errors encountered with appropriate dialogs
// 5) a button that reveals a form for users to enter a preferred meeting time manually
class _MeetingTimeState extends State<MeetingTime> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Unimplemented atm"));
  }
}
