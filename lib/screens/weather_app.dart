import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:weather_app/models/weather_location.dart';
import 'package:weather_app/widgets/buildin_tranformer.dart';

import 'package:weather_app/widgets/single_weather.dart';
import 'package:weather_app/widgets/slider_dot.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
 late String _bgImg;

  _onPageChanged(int index) {
    //updating current page....
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == 'Sunny') {
      _bgImg = 'assets/sunny.jpg';
    } else if (locationList[_currentPage].weatherType == 'Night') {
      _bgImg = 'assets/night.jpg';
    } else if (locationList[_currentPage].weatherType == 'Rainy') {
      _bgImg = 'assets/rainy.jpg';
    } else if (locationList[_currentPage].weatherType == 'Cloudy') {
      _bgImg = 'assets/cloudy.jpeg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            _bgImg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black38),
          ),
          Container(
            margin: EdgeInsets.only(top: 140, left: 15),
            child: Row(
              children: [
                for (int i = 0; i < locationList.length; i++)
                  if (i == _currentPage) SliderDot(true) else SliderDot(false)
              ],
            ),
          ),
          TransformerPageView(
            itemBuilder: (ctx, i) => SingleWeather(i),
            itemCount: locationList.length,
            scrollDirection: Axis.horizontal,
            onPageChanged: _onPageChanged,
            transformer: ScaleAndFadeTransformer(),
            viewportFraction: 0.8,
          ),
        ],
      ),
    );
  }
}
