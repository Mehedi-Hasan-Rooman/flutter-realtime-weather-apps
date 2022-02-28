import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_upwork_project/model%20data/weather_data.dart';
import 'package:flutter_upwork_project/widgets/custom_textstyle.dart';
import 'package:flutter_upwork_project/widgets/extra_weather_widget.dart';

class DetailPage extends StatelessWidget {
  final Weather tomorrowTemp;
  final List<Weather> sevenDay;
  DetailPage(this.tomorrowTemp,this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [TomorrowWeather(tomorrowTemp),
          SevenDays(sevenDay)],
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  final Weather tomorrowTemp;
  TomorrowWeather(this.tomorrowTemp);
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      color: Color(0xfffc1158),
      glowColor: Color(0xfffc1158).withOpacity(0.5),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    Text(
                      " 7 days",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Icon(Icons.more_vert, color: Colors.white)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(tomorrowTemp.image!),
                        fit: BoxFit.cover
                      ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tomorrow",
                      style: TextStyle(fontSize: 24),
                    ),
                    Container(
                      height: 105,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlowText(
                            tomorrowTemp.max.toString(),
                            style: custom_textStyle(60,Colors.black,FontWeight.bold)
                          ),
                          Text(
                            "/" + tomorrowTemp.min.toString() + "\u00B0",
                            style: custom_textStyle(40,Colors.black.withOpacity(0.4),FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    GlowText(
                      " " + tomorrowTemp.name!,
                      style: custom_textStyle(30,Colors.black,FontWeight.w700),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              right: 50,
              left: 50,
            ),
            child: Column(
              children: [
                Divider(color: Colors.white),
                SizedBox(
                  height: 10,
                ),
                ExtraWeather(tomorrowTemp)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  final List<Weather> sevenDay;
  SevenDays(this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: sevenDay.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 25,top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sevenDay[index].day!, style: custom_textStyle(20,Colors.white),),
                    Container(
                      width: 135,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage(sevenDay[index].image!),
                            width: 40,
                          ),
                          SizedBox(width: 15),
                          Text(
                            sevenDay[index].name!,
                            style: custom_textStyle(14,Colors.white),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "+" + sevenDay[index].max.toString() + "\u00B0",
                          style: custom_textStyle(20,Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "+" + sevenDay[index].min.toString() + "\u00B0",
                          style: custom_textStyle(20,Colors.white),
                        ),
                      ],
                    )
                  ],
                ));
          }),
    );
  }
}
