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
  List<WeatherModel>? weatherModel;
  ApiHelper apiHelper=ApiHelper();
  String? input;
  Map<String,String>images=
  {
    'sn':'https://images.pexels.com/photos/209831/pexels-photo-209831.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'sl':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXLoupWIPbipGXnaFqSwIxPNInsRXIOOb7hQ&usqp=CAU',
    'h':'https://c8.alamy.com/comp/MCEDBJ/flakes-and-balls-of-ice-crystals-on-green-grass-after-a-hail-storm-appearing-scenic-in-a-shallow-depth-of-field-landscape-image-MCEDBJ.jpg',
    't':'https://s.w-x.co/util/image/w/gettyimages-1060120946.jpg?crop=16:9&width=480&format=pjpg&auto=webp&quality=60',
    'hr':'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    'ir':'https://s.w-x.co/util/image/w/gettyimages-1060120946.jpg?crop=16:9&width=480&format=pjpg&auto=webp&quality=60',
    's':'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg',
    'hc':'https://images.pexels.com/photos/209831/pexels-photo-209831.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500' ,
    'c': 'https://images.theconversation.com/files/18108/original/rffw88nr-1354076846.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1356&h=668&fit=crop',
    'lc':'https://p0.pikist.com/photos/399/89/sky-light-cloud-weather-mood-landscape-romantic-mystery-light-spreading.jpg',
  };
  String? imagePath;
  bool? exsist=false;
  String? bgImage;
  imagesMethod()
  {
    var e  = images.entries.toList();
    if(weatherModel!=null)
      {
        for(int i=0;i<images.length;i++)
          {
            if(e[i].key==weatherModel![0].icon)
              {
                setState(() {
                  imagePath=e[i].value;
                  exsist=true;
                });
                break;
              }
            else{
              setState(() {
                exsist=false;
              });
            }
          }
      }
    return exsist;
  }
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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover,
            image: NetworkImage(weatherModel==null?'https://images.pexels.com/photos/209831/pexels-photo-209831.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
                :imagesMethod()?
                imagePath!
                :
                'https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg'
            ),
          ),
        ),
        child: SafeArea(
          child: InkWell(
            onTap: ()
            {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: ()
                          {
                            apiHelper.locationData();
                          },
                          child: Icon(Icons.location_city,color: Colors.white,size: 40,))
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.04,),
                SvgPicture.network(weatherModel==null?'https://www.metaweather.com//static/img/weather/c.svg'
                :'https://www.metaweather.com//static/img/weather/${weatherModel![0].icon}.svg',height: 85,
                ),
                SizedBox(height: 20,),
                Text(weatherModel==null?'19'+' °C'
                  :weatherModel![0].temp!.toStringAsFixed(1)+' °C'
                  ,style: TextStyle(fontSize: 40,color: Colors.white),),
                SizedBox(height: 12,),
                Text(weatherModel==null?'Mansoura'
                    :weatherModel![0].cityName==null?'Mansoura':
                     weatherModel![0].cityName!
                  ,style: TextStyle(fontSize: 40,color: Colors.white),),
                SizedBox(height: 12,),
                Container(
                  height: 280,width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weatherModel==null?0:
                      weatherModel!.length,
                      itemBuilder: (context,index){
                    return index!=0? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(weatherModel![index].date.toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.network(weatherModel==null?'https://www.metaweather.com//static/img/weather/c.svg'
                                  :'https://www.metaweather.com//static/img/weather/${weatherModel![0].icon}.svg',height: 60,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(weatherModel![index].stateName.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                            SizedBox(height: 14,),
                            Text('High: '+weatherModel![index].maxTemp!.toStringAsFixed(2),style: TextStyle(fontSize: 25,color: Colors.white),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Low: '+weatherModel![index].minTemp!.toStringAsFixed(2),style: TextStyle(fontSize: 25,color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ):
                    SizedBox();
                  }),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 40),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,color: Colors.white,),
                      hintText: 'Search City',
                      hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)
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
      ),
    );
  }
}
