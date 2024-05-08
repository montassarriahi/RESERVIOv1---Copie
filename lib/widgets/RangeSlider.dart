import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:intl/intl.dart';

class TimeSlider extends StatefulWidget {
  final double startTime;
  final double endTime;
  final Function(dynamic, dynamic) onChanged;

  const TimeSlider({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TimeSliderState createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  late RangeValues value;

  @override
  void initState() {
    super.initState();
    value = RangeValues(widget.startTime, widget.endTime);
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: blueColor,
      divisions: 7,
      labels: RangeLabels(
        _formatTime(value.start),
        _formatTime(value.end),
      ),
      min: 8.0,
      max: 22.0,
      values: value,
      onChanged: (val) {
        setState(() {
          value = val;
          widget.onChanged(val.start, val.end); 
        });
      },
    );
  }

  String _formatTime(double time) {
    int hour = time.toInt() % 24;
    String period = (hour < 12) ? 'AM' : 'PM';
    hour = (hour == 0 || hour == 12) ? 12 : hour % 12;
    return '$hour:00 $period';
  }
}