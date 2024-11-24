class WeatherModel{
  late Location location;
  late Current current;
  WeatherModel.fromJson(Map<String, dynamic>json){
    location = Location.fromJson(json['location']);
    current = Current.fromJson(json['current']);
  }

}

class Location{
  late String city;
  late String country;
  late String time;
  Location.fromJson(Map<String, dynamic> json){
    city = json['name'];
    country = json['country'];
    time = json['localtime'];
  }
}

class Current{
  late num temp;
  late num humidity;
  late Condition condition;
  late bool cloud;
  late bool isDay;
  Current.fromJson(Map<String, dynamic>json){
    temp = json['temp_c'];
    humidity = json['humidity'];
    condition = Condition.fromJson(json['condition']);
    cloud = json['cloud'] == 0 ? false : true;
    isDay = json['is_day'] == 0 ? false : true;
  }
}

class Condition{
  late String icon;
  late String text;

  Condition.fromJson(Map<String, dynamic>json){
    icon = json['icon'];
    text = json['text'];
  }
}