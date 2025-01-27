import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club/pdf/pdf_document.dart';
import 'package:club/pdf/writer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _firebase = FirebaseFirestore.instance;
final String userID = FirebaseAuth.instance.currentUser!.uid;
const String channel = "platform_channel";

class MeetingTime extends StatefulWidget {
  const MeetingTime({
    super.key,
    required this.clubName,
  });
  final String clubName;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextField(
          decoration: InputDecoration(
            label: Text('recommended meeting time: '),
          ),
          readOnly: true,
        ),
        TextField(
          decoration: InputDecoration(
            label: StreamBuilder(
              stream: _firebase
                  .collection('clubs')
                  .doc(widget.clubName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Oops! Something went wrong."),
                  );
                }

                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  final String meetingTime = data['meeting_time'];
                  return Text(meetingTime);
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
          readOnly: true,
        ),
        OutlinedButton(
          child: const Text("Submit School Schedule"),
          onPressed: () {
            PDFDocument doc = PDFDocument();
            doc.load('the_real_schedule.pdf');
            // List<Uint8List> streams = doc.getAllDecompressedStreams();

            // Writer writer = Writer('output.txt');
            // for (Uint8List stream in streams) {
            //   writer.write(stream);
            // }
          },
        ),
      ],
    );
  }
}
