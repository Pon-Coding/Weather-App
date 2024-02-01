import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../fonts/font_style.dart';
import '../logics/weather_logic.dart';
import '../models/weather_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

//get current location
Future<Position> getUserCurrentLocation() async {
  await Geolocator.requestPermission()
      .then((value) {})
      .onError((error, stackTrace) async {
    await Geolocator.requestPermission();
    debugPrint("ERROR" + error.toString());
  });
  return await Geolocator.getCurrentPosition();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      // leadingWidth: 10,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: _buildTextField,
      leading: InkWell(
        onTap: () {
          getUserCurrentLocation().then((value) async {
            context.read<WeatherLogic>().readCurrentLocation(
                currentLocation: LatLng(value.latitude, value.longitude));
          });
          _textEditingController.clear();
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          width: 30,
          height: 30,
          // color: Colors.red,
          child: const Icon(
            Icons.location_on,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (_textEditingController.text.isEmpty) {
                getUserCurrentLocation().then((value) async {
                  context.read<WeatherLogic>().readCurrentLocation(
                      currentLocation: LatLng(value.latitude, value.longitude));
                });
              } else {
                context
                    .read<WeatherLogic>()
                    .read(myCountry: _textEditingController.text);
              }
            });
          },
          child: const Icon(
            Icons.search_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget get _buildBody {
    WeatherModel? weatherList = context.watch<WeatherLogic>().weatherList;
    String? error = context.watch<WeatherLogic>().error;

    if (error != null && weatherList == null) {
      debugPrint(error.toString());
    }
    if (error != null && weatherList != null) {
      return _buildWeather(weatherList);
    } else {
      return _buildWeather(weatherList!);
    }
  }

  Widget get _buildTextField {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 0),
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(106, 224, 224, 224),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: _textEditingController,
        style: mainStyle,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          hintText: "Search your area",
          hintStyle: TextStyle(color: Colors.black.withOpacity(.2)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCloudIcon({int condition = 800, String icon = "04d"}) {
    if (condition <= 804) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 802) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 801) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 800) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 781) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 622) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 531) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 504) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 321) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 232) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (condition <= 200) {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    } else {
      return SvgPicture.asset(
        "assets/svgs/" + icon + ".svg",
        width: 130,
        height: 130,
        fit: BoxFit.cover,
      );
    }
  }

  //Weather --

  Widget _buildWeather(WeatherModel item) {
    String dayOrNight = '';
    if (item.weather[0].icon.contains('n')) {
      setState(() {
        dayOrNight = "night";
      });
    } else {
      setState(() {
        dayOrNight = "morning";
      });
    }
    debugPrint("${item.weather[0].id}");

    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/images/" + dayOrNight + "_background.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 150,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${item.weather[0].description.toUpperCase()} | ",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: item.weather[0].description.length > 13 ? 20 : 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item.name,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: item.weather[0].description.length > 13 ? 20 : 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 180,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${item.main.temp.toStringAsFixed(0)}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 80,
                  fontFamily: 'Lato',
                ),
              ),
              _buildCloudIcon(
                  condition: item.weather[0].id, icon: item.weather[0].icon),
            ],
          ),
        ),
        Positioned(
          top: 320,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Feel Like ${item.main.feelsLike.toStringAsFixed(0)}°C | ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),
              ),
              Text(
                "Humidity ${item.main.humidity.toStringAsFixed(0)}%",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
