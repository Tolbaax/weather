import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:weather/Model/Weather.dart';
class ApiHelper
{
  getWeatherData(cityName)async
  {
    int wid;
    var response = await http.get(Uri.parse('https://www.metaweather.com/api/location/search/?query=$cityName'));
    var body = jsonDecode(response.body);
    wid=body[0]["woeid"];
    var response2 = await http.get(Uri.parse('https://www.metaweather.com/api/location/$wid/'));
    var body2 = jsonDecode(response2.body);
    WeatherModel w = WeatherModel(
      cityName: body[0]["title"],
      temp: body2["consolidated_weather"][0]["the_temp"],
      icon: body2["consolidated_weather"][0]["weather_state_abbr"],
    );
    return w;
  }
}