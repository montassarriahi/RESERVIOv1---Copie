import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';

class ItemCounter extends StatefulWidget {
  final String itemName;
  final IconData myIcon;
  final void Function(int) quantite;

  const ItemCounter({super.key, required this.itemName, required this.myIcon ,  required this.quantite});

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int _itemCount = 0;

  void _incrementCounter() {
    setState(() {
      _itemCount++;
       widget.quantite(_itemCount);
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_itemCount > 0) {
        _itemCount--;
         widget.quantite(_itemCount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 179,
      height: 135,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
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
                        foregroundColor: Colors.blue, // Change text color here
                      ),
                      child: Icon(Icons.remove),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.myIcon,
                      size: 24,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.itemName,
                      style: RegularText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
