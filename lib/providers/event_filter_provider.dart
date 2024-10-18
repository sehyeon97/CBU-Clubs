import 'package:club/models/event_filters/event_semester.dart';
import 'package:club/models/event_filters/event_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// the filter settings are meant to be reset when users reopen app
// by default, the user sees a calendar when opening the events screen
class EventViewProvider extends StateNotifier<EventView> {
  EventViewProvider() : super(EventView.calendar);

  void setView(EventView view) {
    state = view;
  }
}

final eventViewProvider =
    StateNotifierProvider<EventViewProvider, EventView>((ref) {
  return EventViewProvider();
});

// by default the user sees fall semester
class EventSemesterProvider extends StateNotifier<Semester> {
  EventSemesterProvider() : super(Semester.fall);

  void setSemester(Semester semester) {
    state = semester;
  }
}

final eventSemesterProvider =
    StateNotifierProvider<EventSemesterProvider, Semester>(
  (ref) {
    return EventSemesterProvider();
  },
);
