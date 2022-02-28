import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_upwork_project/model%20data/weather_data.dart';
import 'package:flutter_upwork_project/screens/details_page.dart';
import 'package:flutter_upwork_project/widgets/custom_textstyle.dart';
import 'package:flutter_upwork_project/widgets/extra_weather_widget.dart';
import 'package:flutter_upwork_project/widgets/weather_widget.dart';

Weather? currentTemp;
Weather? tomorrowTemp;
List<Weather>? todayWeather;
List<Weather>? sevenDay;
String lat = "53.9006";
String lon = "27.5590";
String city = "Minisk";

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    fetchData(lat, lon, city).then((value) {
      currentTemp = value[0];
      todayWeather = value[1];
      tomorrowTemp = value[2];
      sevenDay = value[3];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff030317),
          body: currentTemp == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [CurrentWeather(getData), TodayWeather()],
                  ),
                )),
    );
  }
}

class CurrentWeather extends StatefulWidget {
  final Function() updateData;

  CurrentWeather(this.updateData);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool searchbar = false;
  bool updating = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchbar) {
          setState(() {
            searchbar = false;
          });
        }
      },
      child: GlowContainer(
        // height: MediaQuery.of(context).size.height / 10 * 7,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.only(top: 10, left: 30, right: 30),
        glowColor: Color(0xfffc1158).withOpacity(0.5),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        color: Color(0xfffc1158),
        spreadRadius: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: searchbar
                  ? TextField(
                      style: custom_textStyle(16, Colors.white),
                      focusNode: focusNode,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintStyle: custom_textStyle(16, Colors.white),
                          fillColor: Color(0xff030317),
                          filled: true,
                          hintText: "Enter a city Name"),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) async {
                        CityModel? temp = await fetchCity(value);
                        if (temp == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color(0xff030317),
                                  title: Text(
                                    "City not found",
                                    style: custom_textStyle(16, Colors.white),
                                  ),
                                  content: Text(
                                    "Please check the city name",
                                    style: custom_textStyle(16, Colors.white),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Ok",
                                          style: custom_textStyle(
                                              16, Colors.white),
                                        ))
                                  ],
                                );
                              });
                          searchbar = false;
                          return;
                        }
                        city = temp.name!;
                        lat = temp.lat!;
                        lon = temp.lon!;
                        updating = true;
                        setState(() {});
                        widget.updateData();
                        searchbar = false;
                        updating = false;
                        setState(() {});
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.square_grid_2x2,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.map_fill, color: Colors.white),
                            GestureDetector(
                              onTap: () {
                                searchbar = true;
                                setState(() {});
                                focusNode.requestFocus();
                              },
                              child: Text(
                                " " + city,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.more_vert, color: Colors.white)
                      ],
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2, color: Colors.white),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                updating ? "Updating" : "Updated",
                style: custom_textStyle(14, Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Container(
                height: 240,
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage(currentTemp!.image!),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GlowText(
                              currentTemp!.current.toString(),
                              style: custom_textStyle(
                                  50, Colors.black, FontWeight.w900),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            GlowText(
                              currentTemp!.name!,
                              style: custom_textStyle(
                                  24, Colors.black, FontWeight.w700),
                            ),
                            GlowText(
                              currentTemp!.day!,
                              style: custom_textStyle(
                                  14, Colors.black, FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            ExtraWeather(currentTemp!)
          ],
        ),
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: custom_textStyle(25, Colors.white, FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DetailPage(tomorrowTemp!, sevenDay!);
                  }));
                },
                child: Row(
                  children: [
                    Text(
                      "7 days ",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 30,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: WeatherWidget(todayWeather![0]),
                  ),
                  Expanded(
                    flex: 1,
                    child: WeatherWidget(todayWeather![1]),
                  ),
                  Expanded(
                    flex: 1,
                    child: WeatherWidget(todayWeather![2]),
                  ),
                  Expanded(
                    flex: 1,
                    child: WeatherWidget(todayWeather![3]),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
