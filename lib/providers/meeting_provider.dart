import 'package:flutter/material.dart';
import '../models/meeting_model.dart';

class MeetingProvider with ChangeNotifier {
  Map<DateTime, List> meetings = {};

  DateTime selectedDay = DateTime.now();

  void onDaySelected(DateTime day, List meetings ,List holidays) {
    print('CALLBACK: _onDaySelected');
    this.selectedDay = day;
    this.meetings[selectedDay] = meetings;
    notifyListeners();
  }

  void scheduleMeeting({mSubject,  mStartTime,tName,mStartDate}) {
    Meeting newMeeting = Meeting(startDate:mStartDate ,
      id: DateTime.now().toString(),
      meetingSubject: mSubject,
        startTime: mStartTime,
      teamName: tName
        );

    //first app load and the event list is null
    if (meetings[mStartDate] == null) {
      meetings[mStartDate] = [newMeeting];
      notifyListeners();
    }
    else {
      meetings[mStartDate].add(newMeeting);
      notifyListeners();
    }
  }
  void deleteEvent(String id){
    final selectedEventIndex=meetings[selectedDay].indexWhere((element) => element.id==id);
    meetings[selectedDay].removeAt(selectedEventIndex);
  }
}
