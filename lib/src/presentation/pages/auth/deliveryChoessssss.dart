import 'package:flutter/material.dart';

class DeliveryTimesDropdown extends StatefulWidget {
  @override
  _DeliveryTimesDropdownState createState() => _DeliveryTimesDropdownState();
}

class _DeliveryTimesDropdownState extends State<DeliveryTimesDropdown> {
  String? selectedTime;
  List<String> deliveryTimes = [
    '08:00 - 10:00 AM',
    '10:00 - 12:00 PM',
    '12:00 - 02:00 PM',
    '02:00 - 04:00 PM',
    '04:00 - 06:00 PM',
    '06:00 - 08:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Times Dropdown'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Delivery Time',
              style: TextStyle(fontSize: 16),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: deliveryTimes.map((time) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedTime == time ? Colors.blue : Colors.white,
                      border: Border.all(
                        color: selectedTime == time ? Colors.blue : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: selectedTime == time ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}