import 'package:flutter/material.dart';

class AJForecastItemView extends StatefulWidget {

  AJForecastItemView({Key key, this.title}) : super(key: key);

  String title;

  @override
  _AJForecastItemView createState() => _AJForecastItemView();
}

class _AJForecastItemView extends State<AJForecastItemView> {
  String _weatherDescription;
  int _currentTemperatureInCelsiusDegrees;
  int _minTemperatureInCelsiusDegrees;
  int _maxTemperatureInCelsiusDegrees;
  String _day;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data')
          ],
        ),
      )
    );
  }
}