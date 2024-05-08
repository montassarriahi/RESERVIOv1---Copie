import 'package:flutter/material.dart';
// import 'package:reserviov1/constants/constants.dart';

class DaySelectionWidget extends StatefulWidget {
  final Map<String, bool> days;
  final Function(String, bool) onToggle;

  const DaySelectionWidget({
    Key? key,
    required this.days,
    required this.onToggle,
  }) : super(key: key);

  @override
  _DaySelectionWidgetState createState() => _DaySelectionWidgetState();
}

class _DaySelectionWidgetState extends State<DaySelectionWidget> {
  late List<bool> _selections;

  @override
  void initState() {
    super.initState();
    _selections = widget.days.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      
      children: widget.days.keys.map((day){  String shortDay = day.substring(0, 3);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal:12, vertical: 10),
          child: Text(shortDay),
        );
      }).toList(),
      isSelected: _selections,
      onPressed: (int index) {
        setState(() {
          _selections[index] = !_selections[index];
          widget.onToggle(widget.days.keys.elementAt(index), _selections[index]);
        });
      },
      color: Colors.black,
      selectedColor: Colors.white,
      fillColor:Color.fromARGB(255, 107, 99, 255) ,
      borderRadius: BorderRadius.circular(10),
      selectedBorderColor: Colors.transparent,
      borderColor: Colors.transparent,
    );
  }
}

