import 'package:flutter/material.dart';
import '../screens/shedule_meeting_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../providers/meeting_provider.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  Widget _buildTableCalendar(MeetingProvider ev) {
    return TableCalendar(
      calendarController: _calendarController,
      events: ev.meetings,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blue,
        todayColor: Colors.blueAccent[100],
        markersColor: Colors.amber,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        titleTextBuilder: (date, locale) {
          return DateFormat.MMMM(locale).format(date);
        },
        titleTextStyle: TextStyle(color: Colors.blue, fontSize: 18),
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        formatButtonShowsNext: false,
      ),
      onDaySelected: ev.onDaySelected,
    );
  }

  Widget _buildEventList(MeetingProvider ev) {
    return ListView(
      children: ev.meetings[ev.selectedDay]
          .map((meeting) => Dismissible(
                key: ValueKey(meeting.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => ev.deleteEvent(meeting.id),
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  alignment: Alignment.centerRight,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: Icon(Icons.today),
                    title: Text(meeting.teamName),
                    //$ using va
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${meeting.meetingSubject} '),
                        Text(
                            'at ${meeting.startTime.hourOfPeriod} :${meeting.startTime.minute} ${meeting.startTime.period == DayPeriod.am ? 'Am' : 'Pm'} ',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    onTap: () => print('$meeting tapped!'),
                  ),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ev = Provider.of<MeetingProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(ev),
          const SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          Expanded(
              child: ev.meetings[ev.selectedDay] == null ||
                      ev.meetings[ev.selectedDay].isEmpty
                  ? Center(
                      child: Icon(
                        Icons.hotel_rounded,
                        size: 100,
                      ),
                    )
                  : _buildEventList(ev)),
        ],
      ),
    );
  }
}
