// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/weather_cubit.dart';
import '../Shared/Constants/colors.dart';
import '../Shared/Widgets/button.dart';
import '../Shared/Widgets/text.dart';
import 'forecast_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  GlobalKey<FormState> formKey = GlobalKey();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = WeatherCubit.get(context);
        // cubit.viewFavourites();
        return Scaffold(
          backgroundColor: AppColors.color1,
          body: Stack(
            children: [
              Container(
                  width: width,
                  height: height,
                  child: Image.asset(
                    "assets/images/3.jpg",
                    fit: BoxFit.cover,
                  )),
              Container(
                width: width,
                height: height,
                color: Colors.black54,
              ),
              Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.014),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: height * 0.07,
                          ),
                          SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              controller: searchController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter city name";
                                }
                              },
                              decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: AppColors.color5,
                                      width: 1,
                                    ),
                                  ),
                                  labelText: 'Enter City Name',
                                  labelStyle: const TextStyle(
                                    color: Colors.white30,
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          BuildButton(
                            height: width * 0.1,
                            width: width * 0.3,
                            text: "Search",
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.hoursWeather = [];
                                cubit.weekWeather = [];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ForecastScreen(
                                            searchController.text)));
                              }
                            },
                            color: AppColors.color1,
                          ),
                          Padding(
                            padding: EdgeInsets.all(width * 0.07),
                            child: SizedBox(
                              height: height * 0.7,
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Stack(children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      ForecastScreen(cubit
                                                          .homeCities[index]
                                                          .location
                                                          .city)));
                                        },
                                        child: Container(
                                          height: height * 0.2,
                                          width: width * 0.8,
                                          decoration: BoxDecoration(
                                            color: index.isEven
                                                ? Colors.green.withOpacity(0.4)
                                                : Colors.white12,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(200),
                                              bottomLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: Row(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(width * 0.04),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BuildText(
                                                    text: cubit
                                                        .homeCities[index]
                                                        .location
                                                        .city,
                                                    bold: true,
                                                    size: width * 0.06,
                                                    color: Colors.white,
                                                  ),
                                                  BuildText(
                                                    text: cubit
                                                            .homeCities[index]
                                                            .current
                                                            .temp
                                                            .toString() +
                                                        " °C",
                                                    bold: true,
                                                    size: width * 0.05,
                                                    color: Colors.white,
                                                  ),
                                                  BuildText(
                                                    text: cubit
                                                        .homeCities[index]
                                                        .location
                                                        .time
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            CircleAvatar(
                                              radius: width * 0.13,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: NetworkImage(
                                                  "https:" +
                                                      cubit
                                                          .homeCities[index]
                                                          .current
                                                          .condition
                                                          .icon),
                                            ),
                                            Row(
                                              children: [
                                                const Spacer(),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: width * 0.08),
                                                  child: BuildText(
                                                    text: cubit
                                                        .homeCities[index]
                                                        .current
                                                        .condition
                                                        .text,
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
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: height * 0.04,
                                    );
                                  },
                                  itemCount: cubit.homeCities.length),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
