import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';

class PriceRooms extends StatefulWidget {
  final void Function(int) onPriceChanged;
  const PriceRooms( {super.key ,  required this.onPriceChanged});

  @override
  State<PriceRooms> createState() => _PriceRoomsState();
}

class _PriceRoomsState extends State<PriceRooms> {
  int _itemCount = 0;

  void _incrementCounter() {
    setState(() {
      _itemCount++;
      widget.onPriceChanged(_itemCount);

    });
  }

  void _decrementCounter() {
    setState(() {
      if (_itemCount > 0) {
        _itemCount--;
        widget.onPriceChanged(_itemCount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          Container(
            child: Row(
              children: [
                Icon(Icons.price_change_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Prix par heure",
                  style: RegularText,
                )
              ],
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _incrementCounter,
                  style: TextButton.styleFrom(
                    foregroundColor: blueColor, // Change text color here
                  ),
                  child: Icon(Icons.add),
                ),
                Text(
                  '$_itemCount',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: _decrementCounter,
                  style: TextButton.styleFrom(
                    foregroundColor: blueColor, // Change text color here
                  ),
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ),

          //
        ],
      ),
    );
  }
}
