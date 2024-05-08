import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';

class EquipmentsToggle extends StatefulWidget {
  final String itemName;
  final IconData myIcon;
final VoidCallback? onPressed;
  const EquipmentsToggle({
    Key? key,
    required this.itemName,
    required this.myIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  _EquipmentsToggleState createState() => _EquipmentsToggleState();
}

class _EquipmentsToggleState extends State<EquipmentsToggle> {
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = List<bool>.filled(1, false); 
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(10),
      fillColor: blueColor,
      borderColor: Colors.black,
      selectedColor: Colors.white,
      selectedBorderColor: Colors.black,
      isSelected: _isSelected,
      onPressed: (int index) {
        setState(() {
         
          _isSelected[index] = !_isSelected[index];
         
          widget.onPressed?.call();
        });
      },
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 157,
              height: 80,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.myIcon,
                    size: 24,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.itemName,
                    style: RegularText,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
