
class WeekForecastModel{
  late var date;
  late num temp;
  late num wind;
  late num rainChance;
  late num snowChance;
  late String condition;
  late String icon;

  WeekForecastModel.fromJson(json){
    date = json['date'];
    temp = json["day"]["avgtemp_c"];
    wind = json["day"]["maxwind_kph"];
    rainChance = json["day"]["daily_chance_of_rain"];
    snowChance = json["day"]["daily_chance_of_snow"];
    condition = json['day']['condition']['text'];
    icon = json['day']['condition']['icon'];


    // json = response["forecast"]["forecastday"]
  }
}