import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/constants/app_text_styles.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/weather_repo.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/widgets/progress_indicator.dart';

import 'city_by_name_screen.dart';

//Flutter StatefulWidget lifecycle
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key ?key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityNameController = TextEditingController();
  Position ?_position;

  bool isLoading = false;
  Map<String, dynamic> ?_data;
  int _celcius = 0;
  String ?_cityName;
  String ?weatherIcon;
  String ?weatherMessage;

  WeatherModel ?weatherModel;

  @override
  void initState() {
    super.initState();
  

    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    getWeatherByCurrentLocation();
   

    print('didChangeDependencies');
  }

  Future<void> getWeatherByCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    weatherModel = await weatherRepo.getWeatherByCurrentLocation();

    setState(() {
      isLoading = false;
    });
  }

  void showSnackbar() {
    // ignore: deprecated_member_use
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: const Text('snack'),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'ACTION',
        onPressed: () {},
      ),
    ));
  }

  // ignore: unused_element
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Write your city'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: (String ?value) {
                  if (value!.isEmpty) {
                    return 'Required field';
                  } else {
                    return null;
                  }
                },
                onChanged: (String danniy) {
                  
                },
                controller: _cityNameController,
                
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                print(
                    '_cityNameController.text before validate: ${_cityNameController.text}');
                if (_formKey.currentState!.validate()) {
                  print(
                      '_cityNameController.text after validate: ${_cityNameController.text}');
                  Navigator.of(context).pop(); //Dialogtu jap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CityByNameScreen(
                        cityName: _cityNameController.text,
                        temp: _celcius, //bul jon gana misal uchun
                      ),
                    ),
                  );
                }
               
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    
    print('dispose');
    super.dispose();
  }

  @override
  void deactivate() {
   
    print('deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      body: Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: isLoading
              ? circularProgress()
              : SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () async {
                              getWeatherByCurrentLocation();
                            },
                            child: const Icon(
                              Icons.near_me,
                              size: 50.0,
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              // _showMyDialog();
                              String typedCity = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const CityScreen();
                                  },
                                ),
                              );

                              if (typedCity != null) {
                                setState(() {
                                  isLoading = true;
                                });
                                weatherModel = await weatherRepo
                                    .getWeatherByCity(typedCity);

                                await Future.delayed(Duration(seconds: 1));

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.location_city,
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '${weatherModel!.celcius}',
                              style: AppTextStyles.tempTextStyle,
                            ), 
                            
                            Text(
                              weatherModel!.icon ?? '☀️',
                              style: AppTextStyles.conditionTextStyle,
                            ), 
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          // ignore: unnecessary_null_comparison
                          weatherModel!.message == null
                              ? 'Weather in ${weatherModel!.cityName}'
                              : '${weatherModel!.message} in ${weatherModel!.cityName}',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.messageTextStyle,
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


