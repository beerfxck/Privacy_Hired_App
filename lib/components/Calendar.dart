import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:privacy_maid_flutter/constant/domain.dart';
import 'package:privacy_maid_flutter/model/timeWork.dart';
import 'package:privacy_maid_flutter/screens/Hiredmaid_page.dart';
import 'package:privacy_maid_flutter/widgets/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class TableEventsExample extends StatefulWidget {
  final int? id_user;
  const TableEventsExample({Key? key, this.id_user}) : super(key: key);
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late String eventJsonString;
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final dio = Dio();
  List<TimeWork> maidWorklist = [];
  @override
  void initState() {
    super.initState();
    getMaidWork();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    
  }

  void getMaidWork() async {
    try {
      Response response = await dio
          .get(url_api + '/maidwork/getwork/' + widget.id_user.toString());
      if (response.statusCode == 200) {
        String jsonString = jsonEncode(response.data);
        eventJsonString = jsonString;
        setState(() {
          updateEventSourceFromJson(_kEventSource, eventJsonString);
        });
        // List<dynamic> responseData = response.data;
        // List<TimeWork> maidWorkList = responseData
        //     .map((dynamic item) => TimeWork.fromJson(item))
        //     .toList();

        // setState(() {
        //   maidWorklist = maidWorkList;
        // });
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  final kEventsNew = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  final _kEventSource = <DateTime, List<Event>>{};

  void updateEventSourceFromJson(
      Map<DateTime, List<Event>> _kEventSource, String jsonStr) {
    final List<dynamic> jsonData = jsonDecode(jsonStr);
    for (var item in jsonData) {
      final DateTime day = DateTime.parse(item['day']);
      final Event event = Event(item['day'], item['day'], item['start_work'],item['end_work']);
      if (_kEventSource.containsKey(day)) {
        _kEventSource[day]!.add(event);
      } else {
        _kEventSource[day] = [event];
      }
    }
    kEventsNew.addAll(_kEventSource);
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    print(kEventsNew[day] ?? []);
    return kEventsNew[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ดูวันการจองคิวแม่บ้าน'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => {
                         Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HiredMaidPage(workday:value[index].date, id_user: widget.id_user,)
                          ),
                        ),
                          print('${value[index].title}'),
                          print('${value[index].date}')
                        },
                        title: Text('เวลาเริ่มงาน: ${value[index].start} เวลาจบงาน: ${value[index].end}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
