import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubits/weather_cubit.dart';
import 'network/Remote/dio_helper.dart';
import 'network/local/database_helper.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initDio();
  await DatabaseHelper.initDatabase();

  runApp(const MiniWeather());
}

class MiniWeather extends StatelessWidget {
  const MiniWeather({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()
        ..viewFavourites()
        ..getForecast(city: "cairo"),
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: 'Mini Weather',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
