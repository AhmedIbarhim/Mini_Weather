// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/weather_cubit.dart';
import '../Shared/Constants/colors.dart';
import '../Shared/Widgets/text.dart';

class ForecastScreen extends StatefulWidget {
  final String cityName;
  const ForecastScreen(this.cityName, {super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  bool isFavourite = false;
  String? backimage;

  @override
  void initState() {
    super.initState();
    var cubit = WeatherCubit.get(context);
    cubit.getAll(widget.cityName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // var cubit = WeatherCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var size = height / width * 2;
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        print(state);
        //WeatherCubit().getForecast(city: widget.cityName);
      },
      builder: (context, state) {
        var cubit = WeatherCubit.get(context);

        isFavourite = cubit.favouriteCities.contains(cubit.cityForecast.name)
            ? true
            : false;

        if (cubit.cityForecast.is_day &&
            cubit.cityForecast.condition.contains("cloud")) {
          backimage = "assets/images/cloudday.jpeg";
        } else if (!cubit.cityForecast.is_day &&
            cubit.cityForecast.condition.contains("cloud")) {
          backimage = "assets/images/cloudnight.jpeg";
        } else if (cubit.cityForecast.is_day &&
            cubit.cityForecast.condition.contains("rain")) {
          backimage = "assets/images/rainday.jpeg";
        } else if (!cubit.cityForecast.is_day &&
            cubit.cityForecast.condition.contains("rain")) {
          backimage = "assets/images/rainnight.jpeg";
        } else if (cubit.cityForecast.is_day &&
            cubit.cityForecast.condition.contains("snow")) {
          backimage = "assets/images/snowday.jpeg";
        } else if (!cubit.cityForecast.is_day &&
            cubit.cityForecast.condition.contains("snow")) {
          backimage = "assets/images/snownight.jpeg";
        } else if (cubit.cityForecast.is_day &&
            cubit.cityForecast.condition.contains("thunder")) {
          backimage = "assets/images/thunderlightiningday.jpg";
        } else if (!cubit.cityForecast.is_day &&
            cubit.cityForecast.condition.contains("thunder")) {
          backimage = "assets/images/thunderlightiningnight.jpg";
        } else if (cubit.cityForecast.is_day) {
          backimage = "assets/images/clearday.jpeg";
        } else if (!cubit.cityForecast.is_day) {
          backimage = "assets/images/clearnight.jpeg";
        } else {
          backimage = "assets/images/1.jpg";
        }

        return Scaffold(
          body: cubit.hoursWeather.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              //state is GetAllLoading ? Center(child: CircularProgressIndicator(),)
              : SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        width: width,
                        height: height,
                        child: Image.asset(
                          backimage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: width,
                        height: height,
                        color: Colors.black54,
                      ),
                      Padding(
                        padding: EdgeInsets.all(size * 2),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: size * 6,
                                left: size * 6,
                                top: size * 3,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      child: isFavourite
                                          ? Icon(
                                              Icons.star,
                                              size: size * 10,
                                              color: AppColors.color5,
                                            )
                                          : Icon(
                                              Icons.star_border,
                                              size: size * 10,
                                              color: AppColors.color5,
                                            ),
                                      onTap: () {
                                        setState(() {
                                          isFavourite = !isFavourite;
                                          if (!cubit.favouriteCities.contains(
                                              cubit.cityForecast.name)) {
                                            cubit
                                                .addFavourite(
                                                    cubit.cityForecast.name)
                                                .then((value) {
                                              var snackBar = SnackBar(
                                                content: Text(
                                                  '${cubit.cityForecast.name} Added to Favourites',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor:
                                                    Colors.green[400],
                                                duration:
                                                    const Duration(seconds: 2),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              cubit.viewFavourites();
                                            });

                                            // cubit.favouriteCities.add(cubit.cityForecast.name);
                                          } else {
                                            cubit
                                                .deleteFavourite(
                                                    cubit.cityForecast.name)
                                                .then((value) {
                                              var snackBar = SnackBar(
                                                content: Text(
                                                  '${cubit.cityForecast.name} Removed from Favourites',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor:
                                                    Colors.red[400],
                                                duration:
                                                    const Duration(seconds: 2),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                            cubit.viewFavourites();
                                            //cubit.favouriteCities.remove(cubit.cityForecast.name);
                                          }
                                          // if(kDebugMode){
                                          //   print(isFavourite);
                                          // }
                                        });
                                      }),
                                  SizedBox(
                                    width: width * 0.06,
                                  ),
                                  BuildText(
                                    text: cubit.cityForecast.localtime
                                        .split(" ")[0],
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: size * 7,
                                    backgroundImage: NetworkImage(
                                        "https:${cubit.cityForecast.icon}"),
                                  )
                                ],
                              ),
                            ),
                            BuildText(
                              text: cubit.cityForecast.name,
                              bold: true,
                              size: size * 7.5,
                            ),
                            BuildText(
                              text: cubit.cityForecast.country,
                              size: size * 4,
                              maxLines: 1,
                              overFlow: true,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BuildText(
                                  text: cubit.cityForecast.mintemp.toString() +
                                      " °C",
                                  size: size * 3,
                                  bold: true,
                                ),
                                BuildText(
                                  text: cubit.cityForecast.temp.toString() +
                                      " °C",
                                  size: size * 5,
                                  bold: true,
                                ),
                                BuildText(
                                  text: cubit.cityForecast.maxtemp.toString() +
                                      " °C",
                                  size: size * 3,
                                  bold: true,
                                ),
                              ],
                            ),
                            BuildText(
                              text: cubit.cityForecast.condition,
                              size: size * 4,
                              maxLines: 1,
                              overFlow: true,
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BuildText(
                                  text:
                                      "Rains : ${cubit.cityForecast.rain.toString()}" +
                                          "  %",
                                  size: size * 2.5,
                                ),
                                BuildText(
                                  text:
                                      "Humidity : ${cubit.cityForecast.humidity.toString()}" +
                                          "  %",
                                  size: size * 2.5,
                                ),
                                BuildText(
                                  text:
                                      "Snows : ${cubit.cityForecast.snow.toString()}" +
                                          "  %",
                                  size: size * 2.5,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 3,
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            SizedBox(
                              height: height * 0.15,
                              child: cubit.hoursWeather.isEmpty
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: AppColors.color1,
                                    ))
                                  : ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: height * 0.07,
                                          width: height * 0.08,
                                          decoration: BoxDecoration(
                                              color: cubit.hoursWeather[index]
                                                          .time
                                                          .split(" ")
                                                          .last
                                                          .split(':')[0] ==
                                                      cubit.cityForecast
                                                          .localtime
                                                          .split(" ")
                                                          .last
                                                          .split(':')[0]
                                                  ? AppColors.color1
                                                  : Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BuildText(
                                                text: cubit
                                                    .hoursWeather[index].time
                                                    .split(" ")
                                                    .last,
                                                size: size * 1.5,
                                                bold: true,
                                              ),
                                              BuildText(
                                                text: cubit.hoursWeather[index]
                                                        .temp
                                                        .toString() +
                                                    " °C",
                                                size: size * 1.5,
                                              ),
                                              BuildText(
                                                text: "Rain : " +
                                                    " ${cubit.hoursWeather[index].rainChance.toString()} %",
                                                size: size * 1.5,
                                              ),
                                              BuildText(
                                                text: "Snow : " +
                                                    " ${cubit.hoursWeather[index].snowChance.toString()} %",
                                                size: size * 1.5,
                                              ),
                                              CircleAvatar(
                                                radius: size * 4,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                    "http:" +
                                                        cubit
                                                            .hoursWeather[index]
                                                            .icon),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                      itemCount: cubit.hoursWeather.length),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            SizedBox(
                              height: height * 0.3,
                              child: cubit.weekWeather.isEmpty
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: AppColors.color1,
                                    ))
                                  : ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: height * 0.15,
                                          decoration: BoxDecoration(
                                              color: index == 0
                                                  ? Colors.white30
                                                  : Colors.white10,
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BuildText(
                                                text: cubit
                                                    .weekWeather[index].date
                                                    .toString()
                                                    .split("-")
                                                    .sublist(1)
                                                    .join(" / "),
                                                size: size * 3.5,
                                                bold: true,
                                              ),
                                              CircleAvatar(
                                                radius: size * 5,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                    "http:" +
                                                        cubit.weekWeather[index]
                                                            .icon),
                                              ),
                                              BuildText(
                                                text: cubit
                                                        .weekWeather[index].temp
                                                        .toString() +
                                                    " °C",
                                                size: size * 3,
                                              ),
                                              BuildText(
                                                text: "Wind : " +
                                                    " ${cubit.weekWeather[index].wind.toString()} km/h",
                                                size: size * 2,
                                              ),
                                              BuildText(
                                                text: "Rain : " +
                                                    " ${cubit.weekWeather[index].rainChance.toString()} %",
                                                size: size * 2,
                                              ),
                                              BuildText(
                                                text: "Snow : " +
                                                    " ${cubit.weekWeather[index].snowChance.toString()} %",
                                                size: size * 2,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: height * 0.1,
                                            width: width * 0.03,
                                            child: const VerticalDivider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                      itemCount: cubit.weekWeather.length),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
