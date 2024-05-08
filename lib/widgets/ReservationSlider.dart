import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';

class RangeValuesSlider extends StatefulWidget {
  final double start;
  final double end;
  final double min;
  final double max;
  final Function(double, double) onChanged;

  const RangeValuesSlider({
    Key? key,
    required this.start,
    required this.end,
    required this.min,
    required this.max,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RangeValuesSliderState createState() => _RangeValuesSliderState();
}

class _RangeValuesSliderState extends State<RangeValuesSlider> {
  late double _start;
  late double _end;

  @override
  void initState() {
    super.initState();
    
    _start = widget.start.clamp(widget.min, widget.max);
    _end = widget.end.clamp(widget.min, widget.max);
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: blueColor,
      divisions: (widget.max - widget.min).toInt(),
      labels: RangeLabels(
        _formatTime(_start),
        _formatTime(_end),
      ),
      values: RangeValues(_start, _end),
      min: widget.min,
      max: widget.max,
      onChanged: (RangeValues values) {
        setState(() {
          _start = values.start;
          _end = values.end;
          widget.onChanged(values.start, values.end);
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
