import 'package:Weather_App/view/AJCurrentWeatherView.dart';
import 'package:Weather_App/view/AJForecastItemView.dart';
import 'package:flutter/material.dart';

class RouteUtil {

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (BuildContext context) => AJCurrentWeatherView(title: 'Current Weather',));
      case '/ForecastItemView':
        return MaterialPageRoute(builder: (BuildContext context) => AJForecastItemView(title: 'Forecast') );
    }
  }
}