import 'package:flutter/material.dart';
import 'package:mates/models/team_model.dart';
import 'package:provider/provider.dart';
import '../widgets/rounded_button.dart';
import '../../providers/meeting_provider.dart';

class ScheduleMeeting extends StatefulWidget {
  static const String routeName = 'schedule_meeting_screen';
  String teamName;

  ScheduleMeeting({this.teamName});

  @override
  _ScheduleMeetingState createState() => _ScheduleMeetingState();
}

class _ScheduleMeetingState extends State<ScheduleMeeting> {
  final TextEditingController nameController = TextEditingController();
  TimeOfDay sPicked;
  DateTime mStartDate;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ev = Provider.of<MeetingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Meeting'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                      controller: nameController,
                      decoration:
                          InputDecoration(labelText: 'Meeting Subject'))),
              /*  SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          labelText: 'Event description'))),*/
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: sPicked == null
                    ? Text('Start Time')
                    : Text(
                        '${sPicked.hourOfPeriod} :${sPicked.minute} ${sPicked.period == DayPeriod.am ? 'Am' : 'Pm'}'),
                trailing: IconButton(
                  icon: Icon(
                    Icons.access_time,
                  ),
                  onPressed: () => pickStartTime(context),
                ),
              ),
              ListTile(
                title: mStartDate == null
                    ? Text('Start Date')
                    : Text(
                        '${mStartDate.day} /${mStartDate.month}/ ${mStartDate.year}'),
                trailing: IconButton(
                  icon: Icon(
                    Icons.access_time,
                  ),
                  onPressed: () => pickStartDate(context),
                ),
              ),
              RoundedButton(
                child: Text(
                  'Schedule',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  return ev.scheduleMeeting(
                    mStartDate: mStartDate,
                    tName: widget.teamName,
                    mSubject: nameController.text,
                    mStartTime: sPicked,
                  );
                },
                borderColor: Color.fromRGBO(142, 238, 238, 1),
                fillinColor: Color.fromRGBO(142, 238, 238, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickStartTime(BuildContext context) async {
    try {
      await showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((value) => setState(() {
                sPicked = value;
              }));
    } catch (e) {
      print(e);
    }
  }

  Future pickStartDate(BuildContext context) async {
    try {
      await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2022))
          .then((value) => setState(() {
                mStartDate = value;
              }));
    } catch (e) {
      print(e);
    }
  }
}
