import 'package:flutter/material.dart';
import 'package:flutter_upwork_project/model%20data/weather_data.dart';
import 'package:flutter_upwork_project/widgets/custom_textstyle.dart';



class WeatherWidget extends StatelessWidget {
  final Weather? weather;
  WeatherWidget(this.weather);
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.white),
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Text(
            weather!.current!.toString() + "\u00B0",
            style: custom_textStyle(20,Colors.white,FontWeight.w700),
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage(weather!.image!),
            width: 50,
            height: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            weather!.time!,
            style: custom_textStyle(16,Colors.white),
          )
        ],
      ),
    );
  }
}