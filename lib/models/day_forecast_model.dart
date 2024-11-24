class DayForeCastModel{
  late String name;
  late String country;
  late num temp;
  late num maxtemp;
  late num mintemp;
  late String localtime;
  late num rain;
  late num snow;
  late num humidity;
  late String condition;
  late String icon;
  late bool is_day;

  DayForeCastModel.fromJson( json){
    name = json["location"]["name"];
    country = json["location"]["country"];
    localtime = json["location"]["localtime"];
    temp = json['current']["temp_c"];
    maxtemp = json["forecast"]["forecastday"][0]["day"]["maxtemp_c"];
    mintemp = json["forecast"]["forecastday"][0]["day"]["mintemp_c"];
    rain = json["forecast"]["forecastday"][0]["day"]["daily_chance_of_rain"];
    snow = json["forecast"]["forecastday"][0]["day"]["daily_chance_of_snow"];
    humidity = json["forecast"]["forecastday"][0]["day"]["avghumidity"];
    condition = json['current']['condition']['text'];
    icon = json['current']['condition']['icon'];
    is_day = json['current']['is_day'] == 0 ? false : true;
  }

}

