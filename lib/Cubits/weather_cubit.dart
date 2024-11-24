import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../Models/day_forecast_model.dart';
import '../Models/week_forecast_model.dart';
import '../models/hour_forecast_model.dart';
import '../models/weather_model.dart';
import '../network/Remote/dio_helper.dart';
import '../network/local/database_helper.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context);

  List<HourForecastModel> hoursWeather = [];
  List<WeekForecastModel> weekWeather = [];
  List<String> favouriteCities = [];
  List<WeatherModel> homeCities = [];
  late DayForeCastModel cityForecast;

  WeatherModel? getCurrentWeather({required String city}) {
    emit(GetCurrentWeatherLoading());
    WeatherModel? cityWeather;
    DioHelper.getCurrentData(city: city).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        cityWeather = WeatherModel.fromJson(value.data);

        emit(GetCurrentWeatherSuccess());
      } else {
        emit(GetCurrentWeatherError(value.statusMessage!));
      }
      return null;
    }).catchError((error) {
      emit(GetCurrentWeatherError(error.toString()));
      return null;
    });

    return cityWeather;
  }

  Future<DayForeCastModel> getForecast({required String city}) async {
    emit(GetForecastLoading());
    DioHelper.getForecastData(city: city).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        cityForecast = DayForeCastModel.fromJson(value.data);
        emit(GetForecastSuccess());
      } else {
        emit(GetForecastError(value.statusMessage!));
      }
    }).catchError((error) {
      emit(GetCurrentWeatherError(error.toString()));
    });
    return cityForecast;
  }

  Future<void> getAll(String cityName) async {
    emit(GetAllLoading());
    cityForecast = await getForecast(city: cityName);
    hoursWeather = getHourWeather(city: cityName);
    weekWeather = getWeekWeather(city: cityName);
    emit(GetAllSuccessFully());
  }

  // void reset(){
  //
  // }
  List<HourForecastModel> getHourWeather({required String city}) {
    emit(GetHourLoading());
    DioHelper.getForecastData(city: city).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        var json = value.data["forecast"]["forecastday"][0]["hour"];
        json.forEach((element) {
          HourForecastModel hour = HourForecastModel.fromJson(element);
          hoursWeather.add(hour);
        });
        emit(GetHourSuccess());
      } else {
        emit(GetHourError(value.statusMessage!));
      }
    }).catchError((error) {
      emit(GetHourError(error.toString()));
    });
    return hoursWeather;
  }

  List<WeekForecastModel> getWeekWeather({required String city}) {
    emit(GetWeekLoading());
    DioHelper.getForecastData(city: city).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        var json = value.data["forecast"]["forecastday"];
        // if(kDebugMode){

        //   print(json.length);
        // }
        json.forEach((element) {
          WeekForecastModel day = WeekForecastModel.fromJson(element);
          weekWeather.add(day);
        });
        emit(GetWeekSuccess());
      } else {
        emit(GetWeekError(value.statusMessage!));
      }
    }).catchError((error) {
      emit(GetWeekError(error.toString()));
    });
    return weekWeather;
  }

  Future<List<String>> getFavourites() async {
    emit(GetFavouritesLoading());
    favouriteCities = [];
    await DatabaseHelper.getAllData().then((value) {
      value.forEach((element) async {
        favouriteCities.add(element['name']);
      });

      emit(GetFavouritesSuccess());
    }).catchError((error) {
      emit(GetFavouritesError(error.toString()));
    });
    return favouriteCities;
  }

  Future<List<WeatherModel>> viewFavourites() async {
    emit(ViewFavouritesLoading());

    homeCities = [];
    await getFavourites().then((value) async {
      value.forEach((element) async {
        await DioHelper.getCurrentData(city: element).then((value) {
          WeatherModel homeCity = WeatherModel.fromJson(value.data);
          homeCities.add(homeCity);
          emit(ViewFavouritesSuccess());
        });
      });
    }).catchError((error) {
      print(error.toString());
    });
    return homeCities;
  }

  Future<void> addFavourite(String city) async {
    emit(AddFavouritesLoading());
    DatabaseHelper.insertData(city: city).then((value) {
      favouriteCities.add(city);
      emit(AddFavouriteSuccess());
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> deleteFavourite(String city) async {
    emit(DeleteFavouritesLoading());
    DatabaseHelper.deleteData(city).then((value) {
      favouriteCities.remove(city);
      emit(DeleteFavouriteSuccess());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
