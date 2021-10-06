import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart'as http;
import 'package:weather/Model/Weather.dart';
class ApiHelper
{
  getWeatherData(cityName)async
  {
    int wid;
    List<WeatherModel> wList=[];
    var response = await http.get(Uri.parse('https://www.metaweather.com/api/location/search/?query=$cityName'));
    var body = jsonDecode(response.body);
    wid=body[0]["woeid"];
    var response2 = await http.get(Uri.parse('https://www.metaweather.com/api/location/$wid/'));
    var body2 = jsonDecode(response2.body);
    body2["consolidated_weather"].forEach(
        (element)
            {
              WeatherModel w = WeatherModel(
                cityName: body[0]["title"],
                temp: element["the_temp"],
                icon: element["weather_state_abbr"],
                maxTemp: element["max_temp"],
                minTemp: element["min_temp"],
                date: element["applicable_date"],
                stateName: element["weather_state_name"],
              );
              wList.add(w);
            }
    );
    return wList;
  }

  locationData()async
  {
    try {
      Position p = await Geolocator.getCurrentPosition();
      print(p.altitude);
      print(p.latitude);
    }
    catch (e,s) {
      print(e);
      print(s);
      // i got `LocationServiceDisabledException` here
    }
  }
  // throw exception here


}