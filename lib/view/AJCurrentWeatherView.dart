import 'package:Weather_App/db/DataFacade.dart';
import 'package:Weather_App/model/KeyAndJSON.dart';
import 'package:Weather_App/model/Weather.dart';
import 'package:Weather_App/net/RESTClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class AJCurrentWeatherView extends StatefulWidget {

  final String title;

  AJCurrentWeatherView({Key key, this.title}) : super(key: key) ;

  _AJCurrentWeatherView createState() => _AJCurrentWeatherView();
}

class _AJCurrentWeatherView extends State<AJCurrentWeatherView>{

  String _weatherDescription;
  double _currentTemperatureInCelsiusDegrees;
  double _minTemperatureInCelsiusDegrees;
  double _maxTemperatureInCelsiusDegrees;
  int _humidityPercentage;
  DateTime _dateOfLastUpdate;
  Map<String, dynamic> _response;

  void _showCurrent() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      Map<String,dynamic> main = _response['main'];
      _dateOfLastUpdate = DateTime.fromMillisecondsSinceEpoch((_response['dt'] as int) * 1000);
      _currentTemperatureInCelsiusDegrees = main['temp'] as double;
      _minTemperatureInCelsiusDegrees = main['temp_min'] as double;
      _maxTemperatureInCelsiusDegrees = main['temp_max'] as double;
      _humidityPercentage = main['humidity'] as int;
      List weathers = _response['weather'];
      for (final weather in weathers) {
        _weatherDescription = weather['description'] as String;
      }
    });
  }

  void _showForecast() {
    Navigator.pushNamed(context, '/ForecastItemView');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(_weatherDescription == null) {
      final db = DataFacade();
      db.weathers().then((value) {
        _response = jsonDecode(value.first.JSONObject);
        _showCurrent();
      });

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(_weatherDescription),
            Text(_currentTemperatureInCelsiusDegrees.toString()),
            Text(_minTemperatureInCelsiusDegrees.toString()),
            Text(_maxTemperatureInCelsiusDegrees.toString()),
            Text(_humidityPercentage.toString()),
            Text(_dateOfLastUpdate.toString())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showForecast,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}