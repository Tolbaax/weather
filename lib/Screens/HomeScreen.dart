import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/Controler/Api_helper.dart';
import 'package:weather/Model/Weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel? weatherModel;
  ApiHelper apiHelper=ApiHelper();
  String? input;
  Map<String,String>images=
  {
    'sn':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXLoupWIPbipGXnaFqSwIxPNInsRXIOOb7hQ&usqp=CAU',
    'sl':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXLoupWIPbipGXnaFqSwIxPNInsRXIOOb7hQ&usqp=CAU',
    'h':'https://c8.alamy.com/comp/MCEDBJ/flakes-and-balls-of-ice-crystals-on-green-grass-after-a-hail-storm-appearing-scenic-in-a-shallow-depth-of-field-landscape-image-MCEDBJ.jpg',
    't':'https://s.w-x.co/util/image/w/gettyimages-1060120946.jpg?crop=16:9&width=480&format=pjpg&auto=webp&quality=60',
    'hr':'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    'ir':'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    's':'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',

    'hc':'https://s.w-x.co/util/image/w/gettyimages-1060120946.jpg?crop=16:9&width=480&format=pjpg&auto=webp&quality=60' ,
    'c': 'https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop'
    ,
    'lc':'https://p0.pikist.com/photos/399/89/sky-light-cloud-weather-mood-landscape-romantic-mystery-light-spreading.jpg',

  };
  getData()
  {
    apiHelper.getWeatherData(input).then((value)
    {
      setState(() {
        weatherModel = value;
        getData();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover,
            image: NetworkImage('https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop')
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.location_city,color: Colors.white,size: 40,)
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.1,),
              SvgPicture.network(weatherModel==null?'https://www.metaweather.com//static/img/weather/c.svg'
              :'https://www.metaweather.com//static/img/weather/${weatherModel!.icon}.svg',height: 85,
              ),
              SizedBox(height: 20,),
              Text(weatherModel==null?'19'+' °C'
                :weatherModel!.temp!.toStringAsFixed(1)+' °C'
                ,style: TextStyle(fontSize: 40,color: Colors.white),),
              SizedBox(height: 35,),
              Text(weatherModel==null?'Mansoura'
                :weatherModel!.cityName!
                ,style: TextStyle(fontSize: 40,color: Colors.white),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 40,left: 40),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,color: Colors.white,),
                    hintText: 'Search City',
                    hintStyle: TextStyle(color: Colors.black)
                  ),
                  onSubmitted: (city)
                  {
                   setState(() {
                     input=city;
                   });
                   getData();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
