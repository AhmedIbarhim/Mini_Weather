part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class GetCurrentWeatherLoading extends WeatherState {}
class GetCurrentWeatherSuccess extends WeatherState {}
class GetCurrentWeatherError extends WeatherState {
  final String message;
  GetCurrentWeatherError(this.message);
}

// Forecast States
class GetForecastLoading extends WeatherState {}
class GetForecastSuccess extends WeatherState {}
class GetForecastError extends WeatherState {
  final String message;
  GetForecastError(this.message);
}
// Hour States
class GetHourLoading extends WeatherState {}
class GetHourSuccess extends WeatherState {}
class GetHourError extends WeatherState {
  final String message;
  GetHourError(this.message);
}
// Week States
class GetWeekLoading extends WeatherState {}
class GetWeekSuccess extends WeatherState {}
class GetWeekError extends WeatherState {
  final String message;
  GetWeekError(this.message);
}



class GetFavouritesLoading extends WeatherState {}
class GetFavouritesSuccess extends WeatherState {}
class GetFavouritesError extends WeatherState {
  final String message;
  GetFavouritesError(this.message);
}


class ViewFavouritesLoading extends WeatherState {}
class ViewFavouritesSuccess extends WeatherState {}
class ViewFavouritesError extends WeatherState {
  final String message;
  ViewFavouritesError(this.message);
}


class AddFavouritesLoading extends WeatherState {}
class AddFavouriteSuccess extends WeatherState {}
class AddFavouritesError extends WeatherState {}


class DeleteFavouritesLoading extends WeatherState {}
class DeleteFavouriteSuccess extends WeatherState {}
class DeleteFavouritesError extends WeatherState {}


class GetAllSuccessFully extends WeatherState{}
class GetAllLoading extends WeatherState{}