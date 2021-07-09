import 'package:flutter/material.dart';

class Meeting{
  String teamName;
  String id;
  String meetingSubject;
  TimeOfDay startTime;
  DateTime startDate;

  Meeting({this.teamName,this.meetingSubject,this.id,this.startTime,this.startDate});
}