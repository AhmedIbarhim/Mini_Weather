import 'package:flutter/material.dart';
import 'text.dart';
import '../../models/weather_model.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({super.key, required this.weatherModel});
  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(children: [
      GestureDetector(
        onTap: () {},
        child: Container(
          height: height * 0.2,
          width: width * 0.8,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(200),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Row(children: [
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildText(
                    text: weatherModel.location.city,
                    bold: true,
                    size: width * 0.06,
                    color: Colors.white,
                  ),
                  BuildText(
                    text: "${weatherModel.current.temp} °C",
                    bold: true,
                    size: width * 0.05,
                    color: Colors.white,
                  ),
                  BuildText(
                    text: weatherModel.location.time
                        .split(" ")
                        .last
                        .split(":")
                        .join(" : "),
                    size: width * 0.04,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(width: width * 0.2),
            SizedBox(width: width * 0.01),
          ]),
        ),
      ),
      SizedBox(
        height: height * 0.2,
        width: width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: width * 0.13,
              backgroundColor: Colors.transparent,
              backgroundImage:
                  NetworkImage(weatherModel.current.condition.icon),
            ),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.08),
                  child: BuildText(
                    text: weatherModel.current.condition.text,
                    size: width * 0.03,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
