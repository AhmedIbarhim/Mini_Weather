
class HourForecastModel{
  late var time;
  late num temp;
  late num rainChance;
  late num snowChance;
  late num clouds;
  late String icon;
  late String condition;


  HourForecastModel.fromJson(json){
    time = json["time"];
    temp = json["temp_c"];
    rainChance = json["chance_of_rain"];
    snowChance = json["chance_of_snow"];
    clouds = json["cloud"];
    icon = json["condition"]["icon"];
    condition = json["condition"]["text"];


    // json = response["forecast"]["forecastday"][0]["hour"]
  }
}